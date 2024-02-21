locals {
  services = toset([
    "bigquery.googleapis.com",
    "serviceusage.googleapis.com",
    "bigqueryconnection.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ])
}

resource "google_project_service" "service" {
  for_each = local.services
  project  = var.gcp_project_id
  service  = each.value
}
