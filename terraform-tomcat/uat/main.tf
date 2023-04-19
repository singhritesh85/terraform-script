module "ec2_ansible_provisioner" {

source = "../ec2-tomcat"

provide_ami = var.provide_ami[var.region]
instance_type = var.instance_type[0]
security_group = var.security_group
subnet_id = var.subnet_id
instance_name = var.instance_name
environment = var.environment
application_loadbalancer_name = var.application_loadbalancer_name
internal = var.internal
load_balancer_type = var.load_balancer_type
subnets = var.subnets
enable_deletion_protection = var.enable_deletion_protection
idle_timeout = var.idle_timeout
target_group_name = var.target_group_name
instance_port = var.instance_port
instance_protocol = var.instance_protocol
target_type_alb = var.target_type_alb
vpc_id = var.vpc_id
load_balancing_algorithm_type = var.load_balancing_algorithm_type
healthy_threshold = var.healthy_threshold
unhealthy_threshold = var.unhealthy_threshold
timeout = var.timeout
interval = var.interval
target_port_path = var.target_port_path
ssl_policy = var.ssl_policy
certificate_arn = var.certificate_arn
type = var.type
}
