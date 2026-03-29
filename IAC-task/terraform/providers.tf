provider "kubernetes" {
  config_path = "/home/ubuntu/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "/home/ubuntu/.kube/config"
  }
}