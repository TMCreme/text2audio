provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "assume_role" {
    statement {
      effect = "Allow"

      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }

      actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type = "zip"
  source_file = "../deployment_package.zip"
  output_path = "deployment_package.zip"
}


resource "aws_lambda_function" "test_lambda" {
  filename = "deployment_package.zip"
  function_name = "audio_gen_webhook"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "app.handler"
  runtime = "python3.8"
}

resource "aws_lambda_function_url" "test_live" {
  function_name = aws_lambda_function.test_lambda.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["*"]
    max_age = 86400
  }
}



