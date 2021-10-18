Steps to create kubernetes Cluster using the Script
====================================================

1. Clone the repository and go the directory k8s-cluster
2. With existing terraform script it will create kubernetes cluster with 3 master and 3 worker nodes and 2 haproxy, you can change the number of counts depending on the requirements and change the terraform script loadbalancer-master-worker/main.tf and loadbalancer-master-worker/hosts.tmpl to generate the inventory/hosts file
3. Change the directory to terraform and run the command terraform apply.
4. Change the directory to ansible and in file haproxy-loadbalancer-backup.conf and haproxy-loadbalancer-master.conf update the IPs of kubernetes master nodes
5. In file keepalived-1.conf and keepalived-2.conf update unicast src ip and unicast peer ip in both the files
6. In file failover-1.sh and failover-2.sh update the Elastic IP and loadbalancer instance id
7. Finally run the command ansible-playbook -i inventory/hosts main.yaml. It will create the complete kubernetes cluster.
