resource "google_compute_instance" "app" {
  name = "app-${var.env}"
  machine_type = "e2-micro"
  zone = "europe-west1-b"
  tags = ["app-${var.env}"]
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}"
  }


  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
}

resource "google_compute_address" "app_ip" {
  name = "app-ip-${var.env}"
}

resource "google_compute_firewall" "firewall_app" {
  name = "allow-app-default-${var.env}"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["9292"]
}
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["app-${var.env}"]
}