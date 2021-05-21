variable "region" {
description = "Provide the AWS Region into which the resource to be created"
type = string
default = "us-east-2"
}

####  variable for lambda function  #####

variable "policy_name" {
description = "Provide the IAM Policy name for lambda function"
type = string
default = "lambda-iam-policy"
}
variable "policy" {
description = "Porvide the IAM Policy File Name to create the IAM policy"
type = string
default = "policy.json"
}
variable "role_name" {
description = "Provide the IAM Role Name for lambda function"
type = string
default = "iam_for_lambda"
}
variable "trust-advisor" {
description = "Provide the lambda function trust advisor file name for IAM role, trust advisor will be presented in this file."
type = string
default = "trust-advisor.json"
}
variable "filename" {
description = "Provide the filename with zip extension to be used for lambda function"
type = string
default = "lambda_function_payload.zip"
}
variable "lambda_function_name" {
description = "Provide the AWS lambda function name"
type = string
default = "test_lambda_function"
}
variable "handler" {
description = "Provide the handler for lambda, it should be name of the lambda function file for code '.' lambda function name"
type = string
default = "lambda_function_payload.lambda_handler"
}
variable "runtime" {
description = "Select the language to be chosen for lambda"
type = list
default = [ "nodejs10.x", "nodejs12.x", "nodejs14.x", "python2.7", "python3.7", "python3.8" ]
}
variable "timeout" {
description = "Provide the timeout of the lambda function"
type = number
default = 240 
}
variable "variable_name" {
description = "Provide the variable name for lambda environment"
type = string
default = "DevOps Engineer"
}


#### variable for sqs dead letter queue  #####

variable "sqs_dlq_name" {
description = "Provide the dlq sqs queue name"
type = string
default = "terraform-dead-letter-queue"
}
variable "dlq_delay_seconds" {
description = "The time in seconds that the delivery of all messages in the queue will be delayed"
type = number
default = 0
}
variable "dlq_max_message_size" {
description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
type = number
default = 262144
}
variable "dlq_message_retention_seconds" {
description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
type = string
default = 345600
}
variable "dlq_receive_wait_time_seconds" {
description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning"
type = number
default = 10
}

variable "dlq_kms_data_key_reuse_period_seconds" {
description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again."
type = number
default = 600
}
variable "dlq_visibility_timeout_seconds" {
description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30."
type = number
default = 240
}
variable "dlq_env" {
description = "Provide the environment for the dlq sqs"
type = string
default = "Production"
}

###### variable for sqs queue  #####

variable "sqs_name" {
description = "Provide the name of the sqs queue"
type = string
default = "terraform-example-queue"
}
variable "sqs_delay_seconds" {
description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
type = number
default = 0
}
variable "sqs_max_message_size" {
description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
type = number
default = 262144
}
variable "sqs_message_retention_seconds" {
description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)."
type = number
default = 345600
}
variable "sqs_receive_wait_time_seconds" {
description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
type = number
default = 10
}
variable "sqs_kms_data_key_reuse_period_seconds" {
description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
type = number
default = 600
}
variable "sqs_visibility_timeout_seconds" {
description = "Provide the sqs visibility timeout in seconds"
type = number
default = 240
}
variable "env" {
description = "Provide the environment of the tag name for sqs"
type = string
default = "Production"
}
