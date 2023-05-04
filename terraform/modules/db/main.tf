resource "google_compute_instance" "db" {
  name = "reddit-db-${var.env}"
  machine_type = "e2-micro"
  zone = "europe-west1-b"
  tags = ["reddit-db-${var.env}"]
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}"
  }


  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.db_ip.address}"
    }
  }
}

resource "google_compute_address" "db_ip" {
  name = "reddit-db-ip-${var.env}"
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default-${var.env}"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["27017"]
  }
  target_tags = ["reddit-db-${var.env}"]
  source_tags = ["reddit-db-${var.env}"]
}