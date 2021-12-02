terraform {
  backend "s3" {
    bucket = "demobucket201911"
    key    = "Test/terraform.tfvars"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-for-extra-masterworker-dynamo"
  }
}
