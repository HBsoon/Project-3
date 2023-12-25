resource "google_artifact_registry_repository" "builded_image" {
  repository_id = var.gar
  format        = "DOCKER"
  location      = var.region
}
