terraform {
 backend "s3" {
   bucket         = "terraform-state-bucket19042023"
   key            = "state/terraform.tfstate"
   region         = "us-east-2"
   encrypt        = true
   dynamodb_table = "terraform-state"
 }
}
