terraform {
}
  provider "google" {
    project = "${var.project}"
    region = "${var.region}"
}
resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "e2-micro"
  zone = "europe-west1-b"
  tags = ["reddit-app"]
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}"
  }
boot_disk {
  initialize_params {
    image = "${var.disk_image}"
  }
}
network_interface {
  network = "default"
access_config {}
}
connection {
  type = "ssh"
  host = self.network_interface.0.access_config.0.nat_ip
  user = "appuser"
  agent = false
  private_key = "${file("~/.ssh/appuser")}"
}

provisioner "file" {
  source = "files/puma.service"
  destination = "/tmp/puma.service"
}

provisioner "remote-exec" {
  script = "files/deploy.sh"
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
