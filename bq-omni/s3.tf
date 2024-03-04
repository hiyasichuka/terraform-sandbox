resource "aws_s3_bucket" "sample" {
  bucket = "test-bucket-888888"
}

# resource "aws_s3_bucket_cors_configuration" "cors" {
#   bucket = aws_s3_bucket.sample.id

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["PUT", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }
# }
