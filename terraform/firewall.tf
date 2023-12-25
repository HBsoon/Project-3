resource "google_compute_firewall" "firewall_ssh" {
  name    = var.firewall_ssh
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.firewall_ssh]
}