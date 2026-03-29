resource "terraform_data" "k3d_cluster" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<-EOT
      set -euo pipefail

      if k3d cluster list | grep -q "microservices"; then
        echo "k3d cluster already exists"
      else
        k3d cluster create microservices \
          --servers 1 \
          --agents 2 \
          -p "8080:80@loadbalancer" \
          -p "3000:3000@loadbalancer"
      fi

      kubectl cluster-info
    EOT
  }
}