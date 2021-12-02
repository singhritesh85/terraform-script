output "Extra_worker_and_master_for_k8s_cluster" {
value = [ module.master_worker ]  #module.ec2_k8s_master, module.ec2_k8s_worker
}
