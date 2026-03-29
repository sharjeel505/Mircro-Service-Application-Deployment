output "cluster_name" {
  value = var.minikube_profile
}

output "argocd_namespace" {
  value = "argocd"
}

output "application_namespace" {
  value = var.app_namespace
}

output "useful_commands" {
  value = <<-EOT
    kubectl get nodes
    kubectl get pods -n argocd
    kubectl get applications -n argocd
    kubectl get pods -n ${var.app_namespace}
    minikube service frontend -n ${var.app_namespace} --url --profile ${var.minikube_profile}
    minikube service api -n ${var.app_namespace} --url --profile ${var.minikube_profile}
  EOT
}