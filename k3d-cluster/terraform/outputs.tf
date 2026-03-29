output "password" {
  description = "Passwords"
  value       = random_password.password.result
  sensitive   = true
}

output "argocd_server_url" {
  description = "ArgoCD server URL via NodePort"
  value       = "http://13.60.86.35:30080"
}
