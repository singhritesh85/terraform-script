module "ec2_iam_attach" {

source = "../module_ec2_iam_attach_iam_to_ec2"
iam_policy_name = var.iam_policy_name
iam_role_name = var.iam_role_name
iam_profile_name = var.iam_profile_name
policy = var.policy
trustedadvisor = var.trustedadvisor
provide_ami = var.provide_ami["us-east-2"]
instance_type = var.instance_type[0]
security_group = var.security_group
subnet_id = var.subnet_id
instance_name = var.instance_name
environment = var.environment
}
