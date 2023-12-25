resource "google_dns_managed_zone" "hyyh_dns" {
  name        = var.dns 
  dns_name    = "hwayangyeonhwa.store." 

  cloud_logging_config {
    enable_logging = true
  }
}

resource "google_dns_record_set" "a_record" {
  name         = "www.${google_dns_managed_zone.hyyh_dns.dns_name}" 
  managed_zone = google_dns_managed_zone.hyyh_dns.name 
  type         = "A" 
  ttl          = 300

  rrdatas = [google_compute_global_address.ip_ingress_address.address]

  depends_on = [google_compute_global_address.ip_ingress_address]
}
