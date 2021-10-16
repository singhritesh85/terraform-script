terraform {
  backend "s3" {
    bucket = "demobucket201911"
    key    = "thambola/tango2/terraform.tfvars"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
