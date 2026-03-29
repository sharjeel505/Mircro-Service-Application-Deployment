variable "kubernetes_version" {
  type    = string
  default = "v1.30.0"
}

variable "app_namespace" {
  type    = string
  default = "microservices"
}

variable "repo_url" {
  type    = string
  default = "https://github.com/sharjeel505/Mircro-Service-Application-Deployment.git"
}

variable "repo_revision" {
  type    = string
  default = "dev"
}