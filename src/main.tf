terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../../Project/analog-reef-399320-e5f4d0d5ea9a.json")

  project = "analog-reef-399320"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "hello_world_network" {
  name = "hello-world-network"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.hello_world_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "hello_world_instance" {
  name         = "hello-world-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.hello_world_network.name
    access_config {

    }
  }

  metadata_startup_script = file("./apache2.sh")
}

output "external_ip" {
  value = google_compute_instance.hello_world_instance.network_interface.0.access_config.0.nat_ip
}
