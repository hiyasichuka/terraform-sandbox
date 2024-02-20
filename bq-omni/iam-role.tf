resource "aws_iam_role" "bigquery-omni-connection-role" {
  name                 = "bigquery-omni-connection"
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
              "accounts.google.com:sub": "00000"
            }
          }
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "bigquery-omni-connection-role-attach" {
  role       = aws_iam_role.bigquery-omni-connection-role.name
  policy_arn = aws_iam_policy.bigquery-omni-connection-policy.arn
}

output "bigquery_omni_role" {
  value = aws_iam_role.bigquery-omni-connection-role.arn
}
