output "ec2_instance_master" {
#  value = aws_instance.ec2_instance_loadbalancer[*].private_ip
  value = aws_instance.ec2_instance_master[*].private_ip
#  value = aws_instance.ec2_instance_worker[*].private_ip
}
output "ec2_instance_worker" {
#  value = aws_instance.ec2_instance_loadbalancer[*].private_ip
#  value = aws_instance.ec2_instance_master[*].private_ip
  value = aws_instance.ec2_instance_worker[*].private_ip
}
