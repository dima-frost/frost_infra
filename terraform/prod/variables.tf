variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
}
variable zone {
  description = "Zone"
  default = "europe-west1-b"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable "env" {
  description = "Environment"
  default = "prod"
}
variable "admin_ip" {
  description = "Admin's ip for ssh"
  default = ["0.0.0.0/0"]
}
