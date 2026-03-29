#!/bin/bash
set -e

TERRAFORM_DIR="/home/ubuntu/Mircro-Service-Application-Deployment/k3d-cluster/terraform"
BOOTSTRAP_MANIFEST="/home/ubuntu/Mircro-Service-Application-Deployment/argocd-workload/apps/bootstrap/app-of-apps.yaml"

ARGOCD_NAMESPACE="argocd"

echo "Terraform apply to provision k3d cluster and ArgoCD..."
cd $TERRAFORM_DIR

terraform init

terraform apply -auto-approve

echo " Terraform apply completed."

echo "Waiting for ArgoCD server to be ready..."
kubectl -n $ARGOCD_NAMESPACE rollout status deployment/argocd-server --timeout=180s

echo " ArgoCD server is ready."

echo "Applying bootstrap App-of-Apps..."
kubectl apply -f $BOOTSTRAP_MANIFEST

echo "Bootstrap App-of-Apps applied successfully."
