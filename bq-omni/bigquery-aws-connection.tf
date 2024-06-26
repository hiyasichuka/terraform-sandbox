resource "google_bigquery_connection" "aws_connection" {
  connection_id = "aws-connection"
  location      = "aws-${var.aws_region}"
  description   = "Created by Terraform"
  aws {
    access_role {
      iam_role_id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bigquery-omni-connection-role"
    }
  }
}

resource "aws_iam_role" "bigquery-omni-connection-role" {
  name                 = "bigquery-omni-connection-role"
  max_session_duration = 43200

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Federated": "accounts.google.com"
          },
          "Action": "sts:AssumeRoleWithWebIdentity",
          "Condition": {
            "StringEquals": {
              "accounts.google.com:sub": "${google_bigquery_connection.aws_connection.aws[0].access_role[0].identity}"
            }
          }
        }
      ]
    }
    EOF
}

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
                      "Resource": ["arn:aws:s3:::${var.aws_s3_bucket_name}"]
                  },
                  {
                      "Sid": "ObjectLevelAccess",
                      "Effect": "Allow",
                      "Action": ["s3:GetObject"],
                      "Resource": [
                          "arn:aws:s3:::${var.aws_s3_bucket_name}",
                          "arn:aws:s3:::${var.aws_s3_bucket_name}/*"
                          ]
                  }
              ]
            }
            EOF
}

resource "aws_iam_role_policy_attachment" "bigquery-omni-connection-role-attach" {
  role       = aws_iam_role.bigquery-omni-connection-role.name
  policy_arn = aws_iam_policy.bigquery-omni-connection-policy.arn
}
