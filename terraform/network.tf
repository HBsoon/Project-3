resource "google_compute_network" "vpc" {
  name                    = var.vpc
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = "0.5"
  }

  depends_on = [google_compute_network.vpc]
}

resource "google_service_networking_connection" "db_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.ip_db_address.name]

  depends_on = [google_compute_global_address.ip_db_address]
}
