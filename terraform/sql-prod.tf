resource "google_sql_database_instance" "sql_prod" {
  name                = var.sql_prod
  database_version    = var.db_version
  root_password       = var.db_password
  deletion_protection = false

  settings {
    tier              = var.prod_tier
    availability_type = "REGIONAL"
    disk_size         = 10

    disk_autoresize       = true
    disk_autoresize_limit = 20

    location_preference {
      zone           = var.zone
      secondary_zone = var.secondary_zone
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    backup_configuration {
      enabled    = true
      start_time = "19:00"
      location   = var.region_dr
    }
  }

  depends_on = [google_service_networking_connection.db_connection]
}


resource "google_sql_database" "carts" {
  name     = "carts"
  instance = google_sql_database_instance.sql_prod.name

  depends_on = [google_service_networking_connection.db_connection]
}
