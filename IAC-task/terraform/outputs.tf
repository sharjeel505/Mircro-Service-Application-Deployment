output "cluster_name" {
  value = "microservices"
}

output "argocd_namespace" {
  value = "argocd"
}

output "application_namespace" {
  value = var.app_namespace
}

output "app_urls" {
  value = {
    frontend = "http://localhost:8080"
    api      = "http://localhost:3000"
  }
}

output "useful_commands" {
  value = <<-EOT
    # Cluster status
    kubectl get nodes

    # Argo CD resources
    kubectl get pods -n argocd
    kubectl get applications -n argocd

    # Application pods
    kubectl get pods -n ${var.app_namespace}

    # Access applications (via k3d load balancer)
    Frontend: http://localhost:8080
    API: http://localhost:3000

    # Test API
    curl http://localhost:3000/api/status
    curl http://localhost:3000/api/quote
  EOT
}