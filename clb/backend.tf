terraform {
  backend "s3" {
    bucket = "demobucket201911"
    key    = "thambola/tango3"
    region = "us-east-2"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
