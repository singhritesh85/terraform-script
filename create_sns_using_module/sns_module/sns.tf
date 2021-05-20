resource "aws_sns_topic" "sns_topic" {
  name = var.name
  display_name = var.display_name
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = var.protocol
  endpoint  = var.endpoint
}
