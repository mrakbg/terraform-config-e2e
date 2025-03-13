
provider "google" {
  # Replace with your service account key file path
  project = "nomadic-basis-448315-n3" # Replace with your current project ID
  region  = "us-central1"             # Default region, can be overridden
}

terraform {
  backend "gcs" {
  name = "anu-uj"
  prefix = "terraform/state"
    
  }
}
resource "google_compute_network" "network" {
  name     = "vpc-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
     name = "subnetworl1"
     network = google_compute_network.network.id
     region = "us-central1"
     ip_cidr_range = "10.0.0.0/16"  
}

resource "google_compute_firewall" "allow-3000" {
     name = "allow-80"
     network = google_compute_network.network.id

     allow {
     protocol = "tcp"
     ports = ["80"]
       
     }
    
     target_tags = ["anuj"]
     source_ranges = ["0.0.0.0/0"]
  
}
resource "google_compute_instance" "compute_engine" {
   name = "e2e"
   machine_type = "e2-micro"
   zone = "us-central1-b"


   network_interface {
     network = "vpc-network"
     subnetwork = "subnetworl1"
     access_config {
       
     }
   }
   boot_disk {
     initialize_params {
       image = "debian-cloud/debian-11"
     }
   } 
    tags = ["anuj"]
}


