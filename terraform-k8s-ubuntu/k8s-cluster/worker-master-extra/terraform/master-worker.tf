module "master_worker" {
source =  "./master-worker"

region = var.region
#name = "web-node"
#count_no_loadbalancer = var.count_no_loadbalancer
count_no_master = var.count_no_master
count_no_worker = var.count_no_worker
amis  = var.amis[var.region]
instance_type = var.instance_type[2]
iam_policy_name = var.iam_policy_name
iam_role_name = var.iam_role_name
iam_profile_name = var.iam_profile_name
policy = var.policy
trustedadvisor = var.trustedadvisor
associate_public_ip_address = var.associate_public_ip_address[0]
subnet_id     = var.subnet_id  
volume_type = var.volume_type[1]
volume_size = var.volume_size
kms_key_id = var.kms_key_id   
inventory_file = var.inventory_file

#loadbalancer_name = var.loadbalancer_name
worker_name = var.worker_name
master_name = var.master_name
}
