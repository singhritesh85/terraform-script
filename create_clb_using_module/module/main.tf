module "create_clb" {
source = "../clb_module"

classic_loadbalancer_name = var.classic_loadbalancer_name
#Availabilty_Zone = [var.Availabilty_Zone[0], var.Availabilty_Zone[1]]
subnet = [ var.subnet[0], var.subnet[1] ]
security_groups = [ var.security_groups[0] ]
instances = [ var.instances[0], var.instances[1] ]
ssl_certificate_id = var.ssl_certificate_id
cross_zone_load_balancing = var.cross_zone_load_balancing
target_port_path = var.target_port_path
bucket = var.bucket
bucket_folder = var.bucket_folder
access_log_interval = var.access_log_interval
connection_draining = var.connection_draining
connection_draining_timeout = var.connection_draining_timeout
idle_timeout = var.idle_timeout
healthy_threshold = var.healthy_threshold
unhealthy_threshold = var.unhealthy_threshold
timeout = var.timeout
interval = var.interval
}
