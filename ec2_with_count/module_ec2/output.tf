output "instance_ip_addr" {
  value = aws_instance.foo.private_ip
}
output "instance_public_ip_address" {
  value = aws_eip.eip_associate.public_ip
}
output "instance_id" {
  value = aws_instance.foo.id
}
