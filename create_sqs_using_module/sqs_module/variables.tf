variable "dlq_name" {
#description = "Provide the dead letter queue name"
#type = string
#default = "terraform-dead-letter-queue"
}
variable "dlq_delay_seconds" {
#description = "Provide the delay seconds"
#type = number
#default = 0
}
variable "dlq_max_message_size" {
#description = "The limit of how many bytes a message can contain before Amazon SQS rejects it, an integer from 1024 bytes (1 KiB) up to 262144 bytes"
#type = number
#default = 262144
}
variable "dlq_message_retention_seconds" {
#description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
#type = number
#default = 345600
}
variable "dlq_receive_wait_time_seconds" {
#description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
#type = number
#default = 10
}
variable "dlq_kms_data_key_reuse_period_seconds" {
#description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
#type = number
#default = 600
}
variable "dlq_visibility_timeout_seconds" {
#description = "Period of time during which Amazon SQS prevents other consumers from receiving and processing the message"
#type = number
#default = 240
}
variable "dlq_env" {
#default = ""
#type = string
#default = "production"
}
variable "name" {
#description = "Providse the name of sqs to be created"
#type = string
#default = "terraform-sqs-queue"
}
variable "delay_seconds" {
#description = "Provide the delay seconds"
#type = number
#default = 0
}
variable "max_message_size" {
#description = "The limit of how many bytes a message can contain before Amazon SQS rejects it, an integer from 1024 bytes (1 KiB) up to 262144 bytes"
#type = number
#default = 262144
}
variable "message_retention_seconds" {
#description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
#type = number
#default = 345600
}
variable "receive_wait_time_seconds" {
#description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
#type = number
#default = 10
}
variable "kms_data_key_reuse_period_seconds" {
#description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
#type = number
#default = 600
}
variable "visibility_timeout_seconds" {
#description = "Period of time during which Amazon SQS prevents other consumers from receiving and processing the message"
#type = number
#default = 240
}
variable "env" {
#default = ""
#type = string
#default = "production"
}
