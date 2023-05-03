provider "google" {
project = "${var.project}"
region = "${var.region}"
}
module "storage-bucket" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 4.0"
  project_id  = "${var.project}"
  names = ["stage", "prod"]
  prefix = "frost-bucket"
  set_admin_roles = true
#  admins = ["group:mashafrost29@gmail.com"]
  versioning = {
    first = true
  }
  bucket_admins = {
    second = "user:mashafrost29@gmail.com"
  }
}
output storage-bucket_url {
value = "${module.storage-bucket.url}"
}