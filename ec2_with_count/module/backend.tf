terraform {
  backend "s3" {
    bucket = "dolo-dempo"
    key = "zalim/lotion/terraform.tfstate"
    region="us-east-2"
    dynamodb_table = "mydb"
  }
}
