resource "google_compute_router" "nat_router" {
  name    = var.nat_router
  region  = var.region
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = var.nat_gateway
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  depends_on = [google_compute_router.nat_router]
}
