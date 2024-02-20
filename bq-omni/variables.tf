variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "gcp_location" {
  description = "GCP location"
  type        = string
  default     = "US"
}

variable "gcp_credential" {
  description = "gcp credential file path"
  type        = string
  sensitive   = true
}

variable "gcp_project_id" {
  description = "GCP project id"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "aws_s3_bucket_name" {
  description = "AWS S3 Bucket name"
  type        = string
  default     = "tsv-files-20240220"
}
