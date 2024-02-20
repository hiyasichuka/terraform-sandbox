resource "aws_iam_policy" "bigquery-omni-connection-policy" {
  name = "bigquery-omni-connection-policy"

  policy = <<-EOF
            {
              "Version": "2012-10-17",
              "Statement": [
                  {
                      "Sid": "BucketLevelAccess",
                      "Effect": "Allow",
                      "Action": ["s3:ListBucket"],
                      "Resource": ["arn:aws:s3:::${aws_s3_bucket.bucket.name}"]
                  },
                  {
                      "Sid": "ObjectLevelAccess",
                      "Effect": "Allow",
                      "Action": ["s3:GetObject"],
                      "Resource": [
                          "arn:aws:s3:::${aws_s3_bucket.bucket.name}",
                          "arn:aws:s3:::${aws_s3_bucket.bucket.name}/*"
                          ]
                  }
              ]
            }
            EOF
}
