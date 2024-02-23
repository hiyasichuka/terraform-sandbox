resource "google_bigquery_dataset" "bigquery_dataset" {
  dataset_id  = "sample"
  description = "Test external data source"
  location    = "aws-${var.aws_region}"
}

#resource "google_bigquery_table" "external_table" {
#  project  = var.gcp_project_id
#  dataset_id = google_bigquery_dataset.bigquery_dataset.dataset_id
#  table_id = "csv"
#
#  external_data_configuration {
#    autodetect    = true
#    source_format = "CSV"
#    source_uris   = ["s3://${aws_s3_bucket.bucket.id}/*.csv"]
#    csv_options {
#      quote = ""
#      skip_leading_rows = 1
#    }
#  }
#
#  depends_on = [
#    google_bigquery_dataset.bigquery_dataset,
#    aws_s3_bucket.bucket
#  ]
#}
