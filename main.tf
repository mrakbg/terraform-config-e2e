provider "google" {
  project = "nomadic-basis-448315-n3" # Replace with your project ID
  region  = "us-central1"
}

terraform {
  backend "gcs" {
    bucket = "anu-uj"                # Corrected from 'name' to 'bucket'
    prefix = "terraform/state"       # Define state storage path
  }
}
# Create a VPC network
resource "google_compute_network" "network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false  # Fixed incorrect string
}

# Create a subnetwork
resource "google_compute_subnetwork" "subnetwork" {
  name           = "subnetwork1" # Fixed typo from "subnetworl1"
  network        = google_compute_network.network.id
  region        = "us-central1"
  ip_cidr_range = "10.0.0.0/16"
}

# Firewall rule to allow traffic on port 80
resource "google_compute_firewall" "allow-http" { # Renamed for clarity
  name    = "allow-http"
  network = google_compute_network.network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["anuj"]
  source_ranges = ["0.0.0.0/0"]
}

# Compute Engine instance
resource "google_compute_instance" "compute_engine" {
  name         = "e2eyui"
  machine_type = "e2-micro"
  zone         = "us-central1-b"
  count        = 2

  network_interface {
    network    = google_compute_network.network.id  # Correct reference
    subnetwork = google_compute_subnetwork.subnetwork.id
    access_config {} # Enables external IP
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  tags = ["anuj"]
}
