variable "bucket" {
#description = "Provide the bucket name"
#type = string
#default = "demo-dempo"
}
variable "acl" {
#description = "Provide the ACL for bucket"
#type = list
#default = [ "private", "public-read", "public-read-write" ]
}
variable "sse_algorithm" {
#description = "Provide the SSE Algorithm"
#type = list
#default = [ "AES256", "aws:kms" ]
}
variable "sns_topic_name" {

}
variable "display_name" {

}
variable "email_endpoint" {

}
variable "env" {
#description = "Provide the Environment name"
#type = string
#default = "Dev"
}
variable "iam_policy_name" {
#description = "Provide the IAM Policy Name"
#type = string
#default = "IAM-Policy-For-Lambda"
}
variable "iam_role_name" {
#description = "Provide the IAM Role Name"
#type = string
#default = "IAM-Role-For-Lambda"
}
variable "trust_relationship" {

}
variable "policy" {

}
variable "lambda_function_name" {
#description = "Provide the Lambda Function Name"
#type = string
#default = "mylambdafunction"
}
variable "retention_in_days" {

}
variable "filename" {

}
variable "handler" {

}
variable "runtime" {

}
