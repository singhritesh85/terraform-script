region = "us-east-2"
count_no_master = 3
count_no_worker = 3
#count_no_loadbalancer = 2
amis = {
    "us-east-1" = "ami-0affd4508a5d2481b"
    "us-west-2" = "ami-0bc06212a56393ee1"
    "us-east-2" = "ami-01e36b7901e884a10"
}
subnet_id = "subnet-e116afad"
instance_type = ["t3.micro", "t3.small", "t3.medium"]
associate_public_ip_address = [true, false]
volume_type = ["io1", "gp2"]
volume_size = 10
kms_key_id = "d4faa181-32bd-48f4-987f-3fb9160caec7"

inventory_file = "../ansible/inventory/hosts"

################# Kubernetes Master Name ######################################

master_name = "k8s-extra-mgmt-master-"


################# Kubernetes Worker Name ######################################

worker_name = "k8s-extra-mgmt-worker-"

################# Kubernetes Worker Name ######################################

#loadbalancer_name = "loadbalancer-"

################# IAM #########################################################

iam_policy_name = "ec2-instance-policy-for-extra-master-and-worker"

iam_role_name = "ec2-instance-role-for-extra-master-and-worker"

iam_profile_name = "ec2-profile-for-extra-master-and-worker"
