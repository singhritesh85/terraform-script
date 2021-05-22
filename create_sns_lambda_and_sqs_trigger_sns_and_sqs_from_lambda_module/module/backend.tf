terraform {
  backend "s3" {
    bucket = "mybucket201911"
    key    = "thambola/tango3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
