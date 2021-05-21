module "sqs_lambda" {
source = "../sqs_trigger_sqs_from_lambda_using_module"

policy_name = var.policy_name
policy = var.policy
role_name = var.role_name
trust-advisor = var.trust-advisor
filename = var.filename
lambda_function_name = var.lambda_function_name
handler = var.handler
runtime = var.runtime[5]
timeout = var.timeout
variable_name = var.variable_name

sqs_dlq_name = var.sqs_dlq_name
dlq_delay_seconds = var.dlq_delay_seconds
dlq_max_message_size = var.dlq_max_message_size
dlq_message_retention_seconds = var.dlq_message_retention_seconds
dlq_receive_wait_time_seconds = var.dlq_receive_wait_time_seconds
dlq_kms_data_key_reuse_period_seconds = var.dlq_kms_data_key_reuse_period_seconds
dlq_visibility_timeout_seconds = var.dlq_visibility_timeout_seconds
dlq_env = var.dlq_env
sqs_name = var.sqs_name
sqs_delay_seconds = var.sqs_delay_seconds
sqs_max_message_size = var.sqs_max_message_size
sqs_message_retention_seconds = var.sqs_message_retention_seconds
sqs_receive_wait_time_seconds = var.sqs_receive_wait_time_seconds
sqs_kms_data_key_reuse_period_seconds = var.sqs_kms_data_key_reuse_period_seconds
sqs_visibility_timeout_seconds = var.sqs_visibility_timeout_seconds
env = var.env
}
