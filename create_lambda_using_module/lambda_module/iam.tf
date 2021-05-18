resource "aws_iam_policy" "lambda_logging" {
  name        = var.policy_name
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = file("${var.policy}")
}

resource "aws_iam_role" "iam_for_lambda" {
  name = var.role_name

  assume_role_policy = file("${var.trust-advisor}")
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
  depends_on = [ aws_iam_policy.lambda_logging, aws_iam_role.iam_for_lambda ]
}
