resource "aws_sqs_queue" "terraform_sqs_dead_letter_queue" {
  name                      = var.dlq_name  # "terraform-dead-letter-queue"
  delay_seconds             = var.dlq_delay_seconds # 0
  max_message_size          = var.dlq_max_message_size # 262144
  message_retention_seconds = var.dlq_message_retention_seconds  #  345600
  receive_wait_time_seconds = var.dlq_receive_wait_time_seconds # 10
  kms_master_key_id = var.dlq_kms_master_key_id  # "3058d813-0bf7-4504-8f5d-f6c0ece556b9"  
  kms_data_key_reuse_period_seconds = var.dlq_kms_data_key_reuse_period_seconds # "600"
  visibility_timeout_seconds = var.dlq_visibility_timeout_seconds   #  240

  tags = {
    Environment = var.dlq_env
  }
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.sqs_name   # "terraform-example-queue"
  delay_seconds             = var.sqs_delay_seconds # 0
  max_message_size          = var.sqs_max_message_size  # 262144
  message_retention_seconds = var.sqs_message_retention_seconds   # 345600
  receive_wait_time_seconds = var.sqs_receive_wait_time_seconds   #  10
  kms_master_key_id = var.sqs_kms_master_key_id  #  "3058d813-0bf7-4504-8f5d-f6c0ece556b9"
  kms_data_key_reuse_period_seconds = var.sqs_kms_data_key_reuse_period_seconds   # "600"
  visibility_timeout_seconds = var.sqs_visibility_timeout_seconds # 240

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_sqs_dead_letter_queue.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "${var.sqs_env}"
  }
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = aws_sqs_queue.terraform_queue.arn
  function_name    = aws_lambda_function.test_lambda.arn 
}
