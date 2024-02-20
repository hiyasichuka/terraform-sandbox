resource "google_bigquery_connection" "aws_connection" {
  connection_id = "aws-connection"
  location      = "aws-${var.aws_region}"
  friendly_name = "👋"
  description   = "BQ Omni Connection"
  aws {
    access_role {
      iam_role_id = aws_iam_role.bigquery-omni-connection-role.arn
    }
  }
}

resource "google_bigquery_connection" "connection" {
  connection_id = "bigquery-omni-aws-connection"
  friendly_name = "bigquery-omni-aws-connection"
  description   = "Created by Terraform"

  location = var.aws_region
  aws {
    access_role {
      # This must be constructed as a string instead of referencing the AWS resources
      # directly to avoid a resource dependency cycle in Terraform.
      iam_role_id = "arn:aws:iam::AWS_ACCOUNT:role/IAM_ROLE_NAME"
    }
  }
}
