# main.tf
provider "google" {
  credentials = file("SA.json")  # Replace with your service account key file path
  project     = "nomadic-basis-448315-n3"                                   # Replace with your current project ID
  region      = "us-central1"                             # Default region, can be overridden
}

resource "google_project" "gungu" {
  name             = "gungu"
  project_id       = "gungu-anuj-mahaan"                   # Unique project ID for your new project
  billing_account  = "01D948-74D0D6-6DC6B7"      
}
