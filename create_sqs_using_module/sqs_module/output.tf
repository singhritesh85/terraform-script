output "url_of_created_sqs" {
value = aws_sqs_queue.terraform_queue.id
}
output "arn_of_created_sqs" {
value = aws_sqs_queue.terraform_queue.arn
}
