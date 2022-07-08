module "ec2_demo" {
source = "../module_ec2"
count = var.instance_count
provide_ami = var.provide_ami["us-east-2"]
instance_type = var.instance_type[0]
security_groups = var.security_groups
subnet_id = var.subnet_id
name="${var.name}-${count.index + 1}"

env = var.environment
}
