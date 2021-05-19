resource "aws_sqs_queue" "terraform_sqs_dead_letter_queue" {
  name                      = "terraform-dead-letter-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 10
  kms_master_key_id = "3058d813-0bf7-4504-8f5d-f6c0ece556b9"  
  kms_data_key_reuse_period_seconds = "600"
  visibility_timeout_seconds = 240

  tags = {
    Environment = "production"
  }
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 10
  kms_master_key_id = "3058d813-0bf7-4504-8f5d-f6c0ece556b9"
  kms_data_key_reuse_period_seconds = "600"
  visibility_timeout_seconds = 240

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_sqs_dead_letter_queue.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}
