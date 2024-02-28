resource "aws_s3_bucket" "bucket" {
  bucket        = var.aws_s3_bucket_name
  force_destroy = true
}

#resource "aws_s3_bucket_cors_configuration" "cors" {
#  bucket = aws_s3_bucket.bucket.id
#
#  cors_rule {
#    allowed_headers = ["*"]
#    allowed_methods = ["PUT", "POST"]
#    allowed_origins = ["*"]
#    expose_headers  = ["ETag"]
#    max_age_seconds = 3000
#  }
#}
