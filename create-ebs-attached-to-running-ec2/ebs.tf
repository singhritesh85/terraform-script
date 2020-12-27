resource "aws_ebs_volume" "ec2_ebs_volume" {
  availability_zone = "us-east-2a"
  size              = var.volume_size
  type              = var.ebs_type[1]
  encrypted         = true
  kms_key_id        = "arn:aws:kms:us-east-2:562086155953:key/0b3b54a1-17ea-4170-8de4-2bc1e28a1656"        ###  The ARN for the KMS encryption key

  tags = {
    Environment = "Dev"
  }
}

## Attach EBS Volume to EC2 Instance
resource "aws_volume_attachment" "attach_ebs" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ec2_ebs_volume.id
  instance_id = "i-0d365f70e33010d41"
}
