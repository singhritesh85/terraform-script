output "instance_ip_addr" {
  value = aws_instance.demo_instance.private_ip
}
output "instance_public_ip_address" {
  value = aws_instance.demo_instance.public_ip
}
output "instance_id" {
  value = aws_instance.demo_instance.id
}
