data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "s3_bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.sample.id
}

output "gcp_big_query_dataset_id" {
  description = "The ID of the dataset"
  value       = google_bigquery_dataset.bigquery_dataset.dataset_id
}

output "bigquery_omni_role" {
  value = aws_iam_role.bigquery-omni-connection-role.arn
}

output "gcp_connection_identity" {
  value = google_bigquery_connection.aws_connection.aws[0].access_role[0].identity
}

output "gcp_connection_location" {
  value = google_bigquery_connection.aws_connection.location
}

#output "external_table_id" {
#  description = "The ID of the BigQuery table"
#  value       = google_bigquery_table.external_table.table_id
#}
