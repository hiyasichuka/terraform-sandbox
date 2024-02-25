# Terraform setting
terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# Archive
data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "build/layer"
  output_path = "lambda/layer.zip"
}
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "build/function"
  output_path = "lambda/function.zip"
}

# Layer
resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name          = "lambda_layer"
  compatible_runtimes = ["python3.10"]
  filename            = data.archive_file.layer_zip.output_path
  source_code_hash    = filebase64sha256(data.archive_file.layer_zip.output_path)
}

# Function
resource "aws_lambda_function" "cost_notifier" {
  function_name    = "cost_notifier"
  handler          = "src/cost_notifier.lambda_handler"
  runtime          = "python3.10"
  filename         = data.archive_file.function_zip.output_path
  role             = aws_iam_role.lambda_exec.arn
  source_code_hash = filebase64sha256(data.archive_file.function_zip.output_path)
  layers           = [aws_lambda_layer_version.lambda_layer.arn]
  memory_size      = 128
  timeout          = 30
}

# Role
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Policy
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-policy"
  description = "IAM policy for the Lambda function"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ce:GetCostAndUsage"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.cost_notifier.function_name}"
  retention_in_days = 30
}