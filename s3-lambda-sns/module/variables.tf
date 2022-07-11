variable "bucket" {
description = "Provide the bucket name"
type = string
default = "demo-dempo"
}
variable "acl" {
description = "Provide the ACL for bucket"
type = list
default = [ "private", "public-read", "public-read-write" ]
}
variable "sse_algorithm" {
description = "Provide the SSE Algorithm"
type = list
default = [ "AES256", "aws:kms" ]
}
variable "env" {
description = "Provide the Environment name"
type = string
default = "Dev"
}
variable "sns_topic_name" {
description = "Provide the SNS Topic Name"
type = string
default = "MyTopic"
}
variable "display_name" {
description = "Provide the SNS Topic Display Name"
type = string
default = "MyTopic"
}
variable "email_endpoint" {
description = "Provide the Group Email Id as an endpoint"
type = string
default = "singhritesh8515@gmail.com"
}
variable "iam_policy_name" {
description = "Provide the IAM Policy Name"
type = string
default = "IAM-Policy-For-Lambda"
}
variable "iam_role_name" {
description = "Provide the IAM Role Name"
type = string
default = "IAM-Role-For-Lambda"
}
variable "trust_relationship" {
description = "Provide the trust advisor for lambda"
type = string
default = "trust-relationship.json"
}
variable "policy" {
description = "Provide the IAM Policy for Lambda Role"
type = string
default = "policy.json"
}
variable "lambda_function_name" {
description = "Provide the Lambda Function Name"
type = string
default = "mylambdafunction"
}
variable "filename" {
description = "Provide the name filename to be uploaded in the lambda function"
type = string
default = "lambda_function_payload.zip"
}
variable "handler" {
description = "Provide the lambda function handler name"
type = string
default = "lambda_function_payload.lambda_handler"
}
variable "runtime" {
description = "Select the Runtime from the list"
type = list
default = [ "nodejs10.x", "nodejs12.x", "nodejs14.x", "python2.7", "python3.7", "python3.8", "python3.9" ]
}
variable "retention_in_days" {
description = "How many days log group will retain the log"
type = number
default = 0 # Cloudwatch Log Group will never expire
}
