output "s3_bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.bucket.id
}

output "gcp_big_query_dataset_id" {
  description = "The ID of the dataset"
  value       = google_bigquery_dataset.bigquery_dataset.dataset_id
}

output "bigquery_omni_role" {
  value = aws_iam_role.bigquery-omni-connection-role.arn
}

#output "external_table_id" {
#  description = "The ID of the BigQuery table"
#  value       = google_bigquery_table.external_table.table_id
#}
