#variable "region" {
#default = "us-east-2"
#}
variable "name" {
#description = "Provide the name of the sns topic"
#type = string
#default = "test-sns-topic"
}

variable "display_name" {
#description = "Provide the display name for the sns topic"
#type = string
#default = "test-sns-topic"
}

variable "protocol" {
#description = "Select the protocol for the SNS Topic"
#type = list
#default = [ "email", "email-json", "sqs", "lambda", "http", "https" ]
}

variable "endpoint" {
#description = "Provide the endpoint for the SNS Subscription"
#type = string
#default = "rksgoal@gmail.com"
}
