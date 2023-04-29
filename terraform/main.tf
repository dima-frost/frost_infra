terraform {
}
  provider "google" {
    project = "infra-384407"
    region = "europe-west-1"
}
resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "e2-micro"
  zone = "europe-west1-b"
  tags = ["reddit-app"]
  metadata = {
    ssh-keys = "appuser:${file("~/.ssh/appuser.pub")}"
  }
boot_disk {
  initialize_params {
    image = "reddit-base-1682758412"
  }
}
network_interface {
  network = "default"
access_config {}
}
}

resource "google_compute_firewall" "firewall_puma" {
name = "allow-puma-default"
network = "default"
allow {
protocol = "tcp"
ports = ["9292"]
}
source_ranges = ["0.0.0.0/0"]
target_tags = ["reddit-app"]
}