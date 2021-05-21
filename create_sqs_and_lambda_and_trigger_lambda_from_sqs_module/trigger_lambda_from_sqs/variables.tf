variable "policy_name" {
#description = "Provide the IAM policy name"
#type = string
#default = "lambda_logging"
}
variable "policy" {
#description = "Provide the policy file name in json"
#type = string
#default = "policy.json"
}
variable "role_name" {
#description = "Provide the IAM Role name"
#type = string
#default = "iam_for_lambda"
}
variable "trust-advisor" {
#description = "Provide the trust advisor file name in json for lambda function."
#type = string
#default = "trust-advisor.json"
}
variable "filename" {
#description = "Path to the function's deployment package within the local filesystem, the filename name should be ended with .zip"
#type = string
#default = "lambda_function_payload.zip"
}
variable "function_name" {
#description = "Provide the lambda function name"
#type = string
#default = "test_lambda_function"
}
variable "handler" {
#description = "Provide the handler for the lambda function, it should be lambda function code file name '.' lambda function definition name"
#type = string
#default = "lambda_function_payload.lambda_handler"
}
variable "runtime" {
#description = "Identifier of the function's runtime. See Runtimes for valid values"
#type = list
#default = [ "nodejs10.x", "nodejs12.x", "nodejs14.x", "python2.7", "python3.7", "python3.8" ]
}
variable "timeout" {
#description = "Provide the timeout in seconds for lambda function"
#type = number
#default = 240
}
variable "env_var" {
#description = "Provide the variable name for lambda environment variable"
#type = string
#default = "DevOps Engineer"
}
variable "dlq_name" {
#description = "Provide the dead letter queue name"
#type = number
#default = "terraform-dead-letter-queue"
}
variable "dlq_delay_seconds" {
#description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
#type = number
#default = 0
}
variable "dlq_max_message_size" {
#description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
#type = number
#default = 262144
}
variable "dlq_message_retention_seconds" {
#description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
#type = number
#default = 345600
}
variable "dlq_receive_wait_time_seconds" {
#description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
#type = string
#default = 10
}
variable "dlq_kms_master_key_id" {
#description = "The length of time, in seconds for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
#type = string
#default = "3058d813-0bf7-4504-8f5d-f6c0ece556b9"
}
variable "dlq_kms_data_key_reuse_period_seconds" {
#description = "The length of time in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
#type = number
#default = 600
}
variable "dlq_visibility_timeout_seconds" {
#description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30"
#type = number
#default = 240
}
variable "dlq_env" {
#description = "Provide the name of the dead letter queue"
#type = string
#default = "Production"
}
variable "sqs_name" {
#description = "Provide the name of the sqs queue"
#type = string
#default = "terraform-example-queue"
}
variable "sqs_delay_seconds" {
#description = "The time in seconds that the delivery of all messages in the queue will be delayed"
#type = number
#default = 0
}
variable "sqs_max_message_size" {
#description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
#type = number
#default = 262144
}
variable "sqs_message_retention_seconds" {
#description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
#type = number
#default = 345600
}
variable "sqs_receive_wait_time_seconds" {
#description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
#type = number
#default = 10
}
variable "sqs_kms_master_key_id" {
#description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
#type = string
#default = "3058d813-0bf7-4504-8f5d-f6c0ece556b9"
}
variable "sqs_kms_data_key_reuse_period_seconds" {
#description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
#type = number
#default = 600
}
variable "sqs_visibility_timeout_seconds" {
#description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
#type = number
#default = 240
}

variable "sqs_env" {
#description = "Provide the sqs environment name"
#type = string
#default = "Production"
}
