module "nlb_module" {
source = "../create_nlb_module"


network_loadbalancer_name = var.network_loadbalancer_name
internal = var.internal
load_balancer_type = var.load_balancer_type
subnets = [ var.subnets[0], var.subnets[1] ]
enable_deletion_protection = var.enable_deletion_protection
enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
access_log_bucket = var.access_log_bucket
prefix = var.prefix
idle_timeout = var.idle_timeout
enabled = var.enabled
target_group_name = var.target_group_name
instance_port = var.instance_port[0]
instance_protocol = var.instance_protocol[0]
target_type_alb = var.target_type_alb[0]
vpc_id = var.vpc_id
load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
stickiness_type = var.stickiness_type[1]
cookie_duration = var.cookie_duration
health_check_protocol = var.health_check_protocol[0]
health_check_port = var.health_check_port[0]
healthy_threshold = var.healthy_threshold
unhealthy_threshold = var.unhealthy_threshold
timeout = var.timeout
interval = var.interval
target_port_path = var.target_port_path
ssl_policy = var.ssl_policy[0]
certificate_arn = var.certificate_arn
http_type = var.http_type[0]  ## Redirect is not valid here, so we have to forward instead of redirect.
https_type = var.https_type[0]
target_id_instance_1 = var.target_id_instance_1
target_id_instance_2 = var.target_id_instance_2
listener_protocol_TCP = var.listener_protocol_TCP

}
