############################################################### Variables for VPC ##################################################################

variable "region" {
  type = string
  description = "Provide the AWS Region into which EKS Cluster to be created"
}

variable "vpc_cidr"{
description = "Provide the CIDR for VPC"
type = string
#default = "10.10.0.0/16"
}

variable "private_subnet_cidr"{
description = "Provide the cidr for Private Subnet"
type = list
#default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "public_subnet_cidr"{
description = "Provide the cidr of the Public Subnet"
type = list
#default = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"]
}

data "aws_partition" "amazonwebservices" {
}

data "aws_region" "reg" {
}

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "G_Duty" {
}

variable "igw_name" {
description = "Provide the Name of Internet Gateway"
type = string
#default = "test-IGW"
}

variable "natgateway_name" {
description = "Provide the Name of NAT Gateway"
type = string
#default = "EKS-NatGateway"
}

variable "vpc_name" {
description = "Provide the Name of VPC"
type = string
#default = "test-vpc"
}

################################################################ Variables for EKS ####################################################################

variable "eks_cluster" {
  type     = string
  description = "Provide the EKS Cluster Name"
}

variable "eks_iam_role_name" {
  type = string
  description = "Provide the EKS IAM Role Name"
}

variable "node_group_name" {
  type = string
  description = "Provide the Node Group Name"
}

variable "eks_nodegrouprole_name" {
  type = string
  description = "Provide the Node Group Role Name"
}

variable "launch_template_name" {
  type = string
  description = "Provide the Launch Template Name"
}

#variable "eks_ami_id" {
#  type = list
#  description = "Provide the EKS AMI ID"
#}

variable "instance_type" {
  type = list
  description = "Provide the Instance Type EKS Worker Node" 
}

variable "disk_size" {
  type = number
  description = "Provide the EBS Disk Size"
}

variable "capacity_type" {
  type = list
  description = "Provide the Capacity Type of Worker Node"
}

variable "ami_type" {
  type = list
  description = "Provide the AMI Type"
}

variable "release_version" {
  type = list
  description = "AMI version of the EKS Node Group"
}

variable "kubernetes_version" {
  type = list
  description = "Desired Kubernetes master version."
}

variable "env" {
  type = list
  description = "Provide the Environment for EKS Cluster and NodeGroup"
}

variable "ebs_csi_name" {
  type = string
  description = "Provide the addon name"
}

variable "ebs_csi_version" {
  type = list
  description = "Provide the ebs csi driver version"
}

variable "csi_snapshot_controller_version" {
  type = list
  description = "Provide the csi snapshot controller version"
}

variable "addon_version_guardduty" {
  type = list
  description = "Provide the addon version for Guard Duty"
}

variable "addon_version_kubeproxy" {
  type = list
  description = "Provide the addon version for kube-proxy"
}

variable "addon_version_vpc_cni" {
  type = list
  description = "Provide the addon version for VPC-CNI"
}

variable "addon_version_coredns" {
  type = list
  description = "Provide the addon version for core-dns"
}

variable "addon_version_observability" {
  type = list
  description = "Provide the addon version for observability"
}

variable "addon_version_podidentityagent" {
  type = list
  description = "Provide the addon version for Pod Identity Agent"
}

variable "addon_version_metrics_server" {
  type = list
  description = "Provide the addon version for Metrics Server"
}

########################################### variables to launch EC2 ############################################################

variable "instance_count" {
  description = "Provide the Instance Count"
  type = number
}

variable "provide_ami" {
  description = "Provide the AMI ID for the EC2 Instance"
  type = map
}

#variable "vpc_security_group_ids" {
#  description = "Provide the security group Ids to launch the EC2"
#  type = list
#}

#variable "subnet_id" {
#  description = "Provide the Subnet ID into which EC2 to be launched"
#  type = string
#}

variable "cidr_blocks" {
  description = "Provide the CIDR Block range"
  type = list
}

variable "kms_key_id" {
  description = "Provide the KMS Key ID to Encrypt EBS"
  type = string
}

variable "name" {
  description = "Provide the name of the EC2 Instance"
  type = string
}

######################################################### Variables to create ALB for Jenkins ################################################################

variable "application_loadbalancer_name" {
  description = "Provide the Application Loadbalancer Name"
  type = string
}
variable "internal" {
  description = "Whether the lodbalancer is internet facing or internal"
  type = bool
}
variable "load_balancer_type" {
  description = "Provide the type of the loadbalancer"
  type = string
}
#variable "subnets" {
#  description = "List of subnets for Loadbalancer"
#  type = list
#}
#variable "security_groups" {     ## Security groups are not supported for network load balancers
#  description = "List of security Groups for Loadbalancer"
#  type = list
#}
variable "enable_deletion_protection" {
  description = "To disavle or enable the deletion protection of loadbalancer"
  type = bool
}
variable "s3_bucket_exists" {
  description = "Create S3 bucket only if doesnot exists."
  type = bool
}
variable "access_log_bucket" {
  description = "S3 bucket to capture Application LoadBalancer"
  type = string
}
variable "prefix" {
  description = "Provide the s3 bucket folder name"
  type = string
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type = number
}
variable "enabled" {
  description = "To capture access log into s3 bucket or not"
  type = bool
}
variable "target_group_name" {
  description = "Provide Target Group Name for Application Loadbalancer"
  type = string
}
variable "instance_port" {    #### Don't apply when target_type is lambda
  description = "Instance Port on which Application will run"
  type = number
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
  description = "The protocol to use for routing traffic to the targets."
  type = string
}
variable "target_type_alb" {
  description = "Select the target type of the Application LoadBalancer"
  type = list
}
#variable "vpc_id" {
#  description = "The identifier of the VPC in which to create the target group."
#  type = string
#}
variable "load_balancing_algorithm_type" {
  description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups."
  type = list
}
variable "healthy_threshold" {
  description = "Provide healthy threshold in seconds, the number of checks before the instance is declared healthy"
  type = number
}
variable "unhealthy_threshold" {
  description = "Provide unhealthy threshold in seconds, the number of checks before the instance is declared unhealthy"
  type = number
}
variable "healthcheck_path" {
  description = "Provide the health check path"
  type = string
}
#variable "ec2_instance_id" {
#  description = "Provide the EC2 Instance ID which is to be attached to the Target Group"
#  type = list
#}
variable "timeout" {
  description = "Provide the timeout in seconds, the length of time before the check times out."
  type = number
}
variable "interval" {
  description = "The interval between checks."
  type = string
}
variable "ssl_policy" {
  description = "Select the SSl Policy for the Application Loadbalancer"
  type = list
}
variable "certificate_arn" {
  description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
  type = string
}
variable "type" {
  description = "The type of routing action."
  type = list
}
