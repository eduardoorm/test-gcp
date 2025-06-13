provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "static_site" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_rule" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

variable "project_id" {}
variable "region" {}
variable "bucket_name" {}