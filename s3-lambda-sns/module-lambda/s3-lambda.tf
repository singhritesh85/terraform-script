resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket
  acl = var.acl
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     =  var.sse_algorithm
      }
    }
  }
  versioning {
    enabled = true
  }
  tags = {
    Environment = var.env
  }
}


resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
  display_name = var.display_name
}


resource "aws_sns_topic_subscription" "user_email_target" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}


resource "aws_cloudwatch_log_group" "cloudwatch_loggroup" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.retention_in_days   # Never Expires
}


resource "aws_iam_policy" "lambda_logging" {
  name        = var.iam_policy_name
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = file("${var.policy}")
}


resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam_role_name

  assume_role_policy = file("${var.trust_relationship}")
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}


resource "aws_lambda_function" "demo_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = var.filename
  handler       = var.handler

  source_code_hash = filebase64sha256("${var.filename}")

  runtime = var.runtime
  
  environment {
    variables = {
      Name = "DevOps Engineer"
    }
  } 

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.cloudwatch_loggroup,
    aws_s3_bucket.demo_bucket
  ]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.demo_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.demo_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.demo_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.demo_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
