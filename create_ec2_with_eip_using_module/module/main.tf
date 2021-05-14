terraform {
  backend "s3" {
    bucket = "mybucket201911"
    key    = "thambola/tango2"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

module "instance" {
source = "../module_ec2_with_eip"
provide_ami = var.provide_ami["us-east-2"]
provide_instance_type = var.provide_instance_type[0]
key_name = var.key_name
security_group = var.security_group
subnet_id = var.subnet_id
environment = var.environment
}
