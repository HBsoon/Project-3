resource "google_sql_database_instance" "sql_dev" {
  name                = var.sql_dev
  database_version    = var.db_version
  root_password       = var.db_password
  deletion_protection = false

  settings {
    tier              = var.dev_tier
    availability_type = "ZONAL"
    disk_size         = 10

    disk_autoresize       = true
    disk_autoresize_limit = 20

    location_preference {
      zone = var.zone
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    backup_configuration {
      enabled    = true
      start_time = "19:00"
      location   = var.region
    }
  }

  depends_on = [google_service_networking_connection.db_connection]
}

resource "google_sql_database" "carts_dev" {
  name     = "carts"
  instance = google_sql_database_instance.sql_dev.name

  depends_on = [google_service_networking_connection.db_connection]
}
