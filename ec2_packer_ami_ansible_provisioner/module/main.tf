module "ec2_ansible_provisioner" {

source = "../ec2_module"

AMI_ID = var.AMI_ID 
instance_type = var.instance_type[0]
security_group = var.security_group
subnet_id = var.subnet_id
instance_name = var.instance_name
environment = var.environment

}
