module "sqs_module" {
source = "../sqs_module"

dlq_name = var.dlq_name
dlq_delay_seconds = var.dlq_delay_seconds
dlq_max_message_size = var.dlq_max_message_size
dlq_message_retention_seconds = var.dlq_message_retention_seconds
dlq_receive_wait_time_seconds = var.dlq_receive_wait_time_seconds
dlq_kms_data_key_reuse_period_seconds = var.dlq_kms_data_key_reuse_period_seconds
dlq_visibility_timeout_seconds = var.dlq_visibility_timeout_seconds
dlq_env = var.dlq_env
name = var.name
delay_seconds = var.delay_seconds
max_message_size = var.max_message_size
message_retention_seconds = var.message_retention_seconds
receive_wait_time_seconds = var.receive_wait_time_seconds
kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
visibility_timeout_seconds = var.visibility_timeout_seconds
env = var.env
}
