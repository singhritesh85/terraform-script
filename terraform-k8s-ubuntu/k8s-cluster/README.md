Steps to create kubernetes Cluster using the Script
====================================================

1. Clone the repository and go the directory k8s-cluster
2. With existing terraform script it will create kubernetes cluster with 3 master and 3 worker nodes and 2 haproxy, you can change the number of counts depending on the requirements and change the terraform script loadbalancer-master-worker/main.tf and loadbalancer-master-worker/hosts.tmpl to generate the inventory/hosts file
3. Change the directory to terraform and run the command terraform apply.
4. Change the directory to ansible and in file haproxy-loadbalancer-backup.conf and haproxy-loadbalancer-master.conf update the IPs of kubernetes master nodes
5. In file keepalived-1.conf and keepalived-2.conf update unicast src ip and unicast peer ip in both the files
6. In file failover-1.sh and failover-2.sh update the Elastic IP and loadbalancer instance id
7. In file masternode.yaml update the Elastic IP (which is now assigned to one of the loadbalancer) in the command kubeadm init --control-plane-endpoint "18.220.46.18:8443" --upload-certs --pod-network-cidr=192.168.0.0/16 --v=5
8. Finally run the command ansible-playbook -i inventory/hosts main.yaml. It will create the complete kubernetes cluster.


Steps to Add More Master and Worker Nodes to the Kubernetes Cluster
====================================================================

1. Update the terraform.tfvars file present in the directory worker-master-extra as required.
2. To Add more master and worker nodes to the kubernetes cluster go to the directory worker-master-extra and then terraform; run the command terraform apply -auto-approve.
3. Then go to one directory back into ansible directory, update the file haproxy-loadbalancer-master.conf and haproxy-loadbalancer-backup.conf. Update all the nodes IP as required in the two files haproxy-loadbalancer-master.conf and haproxy-loadbalancer-backup.conf.
4. First of all run the command "ansible-playbook -i ../../../k8s-cluster/ansible/inventory/hosts create-loadbalancer.yaml" to update the kubernetes master nodes for all the kubernetes masters into the haproxy loadbalancer.  (Use an inventory for two existing loadbalancers IPs and as the one loadbalancer uses the Elastic IP)
5. Finally run the command ansible-playbook -i inventory/hosts main.yaml.
