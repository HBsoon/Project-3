terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.79"
    }
  }
}

provider "google" {
  credentials = var.hyyh_cred
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  credentials = var.hyyh_cred
  project     = var.project
  region      = var.region
}

