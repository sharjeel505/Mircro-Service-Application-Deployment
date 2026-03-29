resource "kubernetes_manifest" "argocd_project" {
  depends_on = [
    terraform_data.k3d_cluster,
    helm_release.argocd
  ]

  manifest = yamldecode(file("${path.module}/../argocd/project.yaml"))
}

resource "kubernetes_manifest" "argocd_root_app" {
  depends_on = [
    terraform_data.k3d_cluster,
    helm_release.argocd,
    kubernetes_manifest.argocd_project
  ]

  manifest = yamldecode(file("${path.module}/../argocd/root-application.yaml"))
}