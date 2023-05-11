#variable source_ranges {
#  description = "Allowed IP addresses"
#  default = ["0.0.0.0/0"]
#}
variable "env" {
  description = "Environment"
}
variable "admin_ip" {
  description = "Admin's ip for ssh"
  default = ["0.0.0.0/0"]
}