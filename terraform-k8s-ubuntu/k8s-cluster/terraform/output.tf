output "loadbalancer_k8s_cluster_nodes" {
value = [ module.loadbalancer_master ]  #module.ec2_k8s_master, module.ec2_k8s_worker
}
