terraform {
}
  provider "google" {
    project = "${var.project}"
    region = "${var.region}"
}

module "app" {
  source = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  env = "${var.env}"
  app_disk_image = "${var.disk_image}"
}

module "db" {
  source = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  env = "${var.env}"
  db_disk_image = "${var.disk_image}"
}

module "vpc" {
  source = "../modules/vpc"
  source_ranges = "${var.admin_ip}"
  env = "${var.env}"
}
 


#connection {
 # type = "ssh"
 # host = self.network_interface.0.access_config.0.nat_ip
 # user = "appuser"
 # agent = false
 # private_key = "${file("~/.ssh/appuser")}"
#}

#provisioner "file" {
 # source = "files/puma.service"
 # destination = "/tmp/puma.service"
#}

#provisioner "remote-exec" {
 # script = "files/deploy.sh"
#}
