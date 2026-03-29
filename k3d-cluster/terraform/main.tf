resource "k3d_cluster" "k3d" {
  name    = var.cluster_name
  servers = 1
  agents  = 2
  image   = var.cluster_image


  kube_api {
    host_ip   = "0.0.0.0"
    host_port = 6443
  }

  port {
    host_port      = 443
    container_port = 443
    node_filters   = ["loadbalancer"]
  }

  port {
    host_port      = 80
    container_port = 80
    node_filters   = ["loadbalancer"]
  }

  k3d {
    disable_load_balancer = false
    disable_image_volume  = false
  }

  k3s {
    extra_args {
      arg          = "--disable=traefik"
      node_filters = ["server:0"]
    }
  }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = true
  }
}

resource "helm_release" "ingress" {
  depends_on = [k3d_cluster.k3d]
  name       = "nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.6.1"
  values           = [file("values/ingress-nginx.yaml")]
}

data "external" "getip" {
  program = ["bash", "${path.module}/getip.sh"]
}


resource "random_password" "password" {
  length           = 16
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?@"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = true
  version          = "3.3.5"

  values = [
    yamlencode({
      server = {
        service = {
          type     = "NodePort"
          nodePort = 30080   
        }
      }
    })
  ]
}


#resource "kubernetes_manifest" "bootstrap_app" {
#  manifest = yamldecode(file("/home/ubuntu/Mircro-Service-Application-Deployment/argocd-workload/apps/bootstrap/app-of-apps.yaml"))
#  depends_on = [
#    helm_release.argocd,
#    k3d_cluster.k3d
#  ]
#}

