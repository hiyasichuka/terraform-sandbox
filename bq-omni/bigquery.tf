resource "google_bigquery_dataset" "bigquery_dataset" {
  dataset_id                 = "sample"
  description                = "Test external data source"
  location                   = "aws-${var.aws_region}"
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "external_table" {
  project             = var.gcp_project_id
  dataset_id          = google_bigquery_dataset.bigquery_dataset.dataset_id
  table_id            = "sample_table"
  deletion_protection = false

  external_data_configuration {
    autodetect    = true
    connection_id = google_bigquery_connection.connection.id
    source_format = "CSV"
    source_uris   = ["s3://${aws_s3_bucket.bucket.id}/*"]
    csv_options {
      quote                 = "\""
      skip_leading_rows     = 1
      allow_quoted_newlines = true
    }
  }

  depends_on = [
    google_bigquery_dataset.bigquery_dataset,
    aws_s3_bucket.bucket,
    google_bigquery_connection.connection,
    aws_iam_openid_connect_provider.default
  ]
}
