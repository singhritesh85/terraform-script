terraform {
  backend "s3" {
    bucket = "mybucket201911"
    key    = "thambola/tango2"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}


module "myresource" {
source = "../module_for_create_iam_ec2_s3"

policy_name = "${var.policy_name}"
role_name = "${var.role_name}"
provide_ami = var.provide_amis["us-east-2"]
instance_type = var.instance_types[0]  

key_name = "${var.key_name}"
provide_security_group = var.provide_security_group

subnet_id = var.subnet_id
instance_name = var.instance_name


bucket_name = var.bucket_name
access_control_list = var.access_control_list
enabled_disabled_versioning = var.enabled_disabled_versioning
sse_algorithm = var.sse_algorithm
tag = var.tag
}
