resource "aws_sns_topic" "sns_topic" {
  name = "user-test-topic"
  display_name = "user-test-topic"
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "rksgoal@gmail.com"
}
