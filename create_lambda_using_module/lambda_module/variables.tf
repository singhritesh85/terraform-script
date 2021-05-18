variable "policy_name" {
#description = "Provide the IAM Policy Name"
#type = string
#default = "lambda_iam_policy"
}
variable "role_name" {
#description = "Provide the IAM Role Name"
#type = string
#default = "lambda_iam_role"
}
variable "policy" {
#description = "Provide the json file name used for IAM policy generation"
#type = string
#default = "policy.json"
}
variable "trust-advisor" {
#description = "Provide the trust advisor in json for lambda function IAM Role"
#type = string
#default = "trust-advisor.json"
}
variable "filename" {
#description = "Provide the filename for your lambda function code in zip format"
#type = string
#default = "lambda_function_payload.zip"  # Provide the filename in zip format
}
variable "function_name" {
#description = "Provide the lambda function name"
#type = string
#default = "test-lambda"
}
variable "handler" {
#description = "Provide the handler for lambda function" # The lambda function should be written as name of the file '.' function name. Example:- lambda_function_payload.lambda_handler where lambda_function_payload.py is the function name and lambda_handler is the lambda function name.
#type = string
#default = "lambda_function_payload.lambda_handler"
}
variable "runtime" {
#description = "Select the runtime from the list"
#type = list
#default = [ "nodejs10.x", "nodejs12.x", "nodejs14.x", "python2.7", "python3.7", "python3.8" ]
}
variable "timeout" {
#description = "Provide the timeout in seconds"
#type = number
#default = 240
}
variable "env_variable1" {
#description = "Provide the first Environment variable value"
#type = string
#default = "DevOps Engineer"
}
variable "env_variable2" {
#description = "Provide the second Environment variable value"
#type = string
#default = "Work In Progress"
}
