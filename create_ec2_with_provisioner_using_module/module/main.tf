module "ec2_with_provisioner" {
source = "../ec2_provisioner"

provide_ami = var.provide_ami["us-east-2"]
instance_type = var.instance_type[0]
security_group = var.security_group
subnet_id = var.subnet_id
instance_name = var.instance_name
environment = var.environment
}
