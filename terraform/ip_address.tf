resource "google_compute_global_address" "ip_ingress_address" {
  name = var.ip_ingress_address

  depends_on = [google_compute_network.vpc]
}

resource "google_compute_global_address" "ip_db_address" {
  name = var.ip_db_address

  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = google_compute_network.vpc.id

  depends_on = [google_compute_network.vpc]
}
