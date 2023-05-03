terraform {
 backend "gcs" {
   bucket  = "frost-bucket-stage"
   prefix  = "terraform/state"
 }
}