module "lambda_function" {
source = "../lambda_module"

policy_name = var.policy_name
role_name = var.role_name
filename = var.filename
function_name = var.function_name
policy = var.policy
trust-advisor = var.trust-advisor
handler = var.handler
runtime = var.runtime[5]
timeout = var.timeout
env_variable1 = var.env_variable1
env_variable2 = var.env_variable2
}
