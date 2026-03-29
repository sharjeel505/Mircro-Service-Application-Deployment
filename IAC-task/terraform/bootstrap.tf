resource "kubernetes_manifest" "argocd_project" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(file("${path.module}/../argocd/project.yaml"))
}

resource "kubernetes_manifest" "argocd_root_app" {
  depends_on = [
    helm_release.argocd,
    kubernetes_manifest.argocd_project
  ]

  manifest = yamldecode(file("${path.module}/../argocd/root-application.yaml"))
}