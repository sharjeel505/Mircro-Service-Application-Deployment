resource "kubernetes_namespace" "argocd" {
  depends_on = [terraform_data.k3d_cluster]

  metadata {
    name = "argocd"
  }
}

resource "kubernetes_namespace" "apps" {
  depends_on = [terraform_data.k3d_cluster]

  metadata {
    name = var.app_namespace
  }
}

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace.argocd]

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = false
  version          = "7.7.16"

  values = [
    yamlencode({
      configs = {
        params = {
          "server.insecure" = true
        }
      }
      server = {
        service = {
          type = "NodePort"
        }
      }
    })
  ]
}