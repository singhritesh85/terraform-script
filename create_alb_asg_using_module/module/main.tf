terraform {
  backend "s3" {
    bucket = "mybucket201911"
    key    = "thambola/tango2/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

module "alb_asg" {

source = "../module_alb_asg"
application_loadbalancer_name = var.application_loadbalancer_name
internal = var.internal
load_balancer_type = var.load_balancer_type
subnets = var.subnets
loadbalancer_security_groups = var.loadbalancer_security_groups
enable_deletion_protection = var.enable_deletion_protection
access_log_bucket = var.access_log_bucket
prefix = var.prefix
idle_timeout = var.idle_timeout
enabled = var.enabled
target_group_name = var.target_group_name
instance_port = var.instance_port
instance_protocol = var.instance_protocol
target_type_alb = var.target_type_alb[0]
vpc_id = var.vpc_id
load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
stickiness_type = var.stickiness_type[0]
cookie_duration = var.cookie_duration
healthy_threshold = var.healthy_threshold
unhealthy_threshold = var.unhealthy_threshold
timeout = var.timeout
interval = var.interval
target_port_path = var.target_port_path
ssl_policy = var.ssl_policy[0]
certificate_arn = var.certificate_arn
http_type = var.http_type[1]
https_type = var.https_type[0]

################### variables for Launch Configuration #########################

launch_configuration_name = var.launch_configuration_name
instance_type = var.instance_type[0]
launch_configuration_image_id = var.launch_configuration_image_id
iam_instance_profile = var.iam_instance_profile
enable_monitoring = var.enable_monitoring
ebs_optimized = var.ebs_optimized[0]
key_name = var.key_name[0]
security_groups = [ var.security_groups[0], var.security_groups[1], var.security_groups[2] ]
associate_public_ip_address = var.associate_public_ip_address
placement_tenancy = var.placement_tenancy[0]
#device_name = var.device_name  ### To be applied in case of extra volume attached
#volume_type = var.volume_type[1]  ### To be applied in case of extra volume attached
#volume_size = var.volume_size  ### To be applied in case of extra volume attached
#iops = var.iops  ### To be applied in case of extra volume attached
#delete_on_termination = var.delete_on_termination[0]   ### To be applied in case of extra volume attached
#encrypted = var.encrypted[0]  ### To be applied in case of extra volume attached

#######################variables for Autoscaling Group###############################

min_size = var.min_size
max_size = var.max_size
desired_capacity = var.desired_capacity
default_cooldown = var.default_cooldown
service_linked_role_arn = var.service_linked_role_arn
health_check_type = var.health_check_type

#######################################cloudwatch for AutoScaling Group###############################################

treat_missing_data = var.treat_missing_data[0]

}
