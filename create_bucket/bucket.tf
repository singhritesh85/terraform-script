terraform {
  backend "s3" {
    bucket = "demobucket201911"
    key    = "thambola/tango2"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket = "bucket20201129"
  acl    = "public-read-write"

  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Environment = "Dev"
  }
}
