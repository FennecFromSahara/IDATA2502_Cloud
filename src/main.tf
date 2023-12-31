terraform {
  backend "gcs" {
    bucket      = "portfolio-fennecfromsahara-bucket"
    prefix      = "terraform/state"
    credentials = "gcp-credentials.json"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "hello_world_network" {
  name = var.network_name
}

resource "google_compute_firewall" "hello_world_firewall" {
  name    = var.firewall_name
  network = google_compute_network.hello_world_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "hello_world_instance" {
  name         = var.instance_name
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.hello_world_network.name
    access_config {
      # add empty access_config in order to omit nat_ip
    }
  }

  metadata_startup_script = file("./apache2.sh")
}

output "external_ip" {
  value = google_compute_instance.hello_world_instance.network_interface.0.access_config.0.nat_ip
}
