provider "google" {
  credentials = file(var.gcp_credential)
  project     = var.gcp_project_id
  region      = var.gcp_region
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
