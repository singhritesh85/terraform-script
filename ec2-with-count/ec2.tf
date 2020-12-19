resource "aws_instance" "demo_instance" {
  ami           = var.ami["us-east-2"]
  instance_type = "t3.micro"
  key_name = "key"
  count = var.counts
#  cpu_core_count = 4
#  cpu_threads_per_core = 2
#  availability_zone = var.availability_zone[0]
  monitoring = true
  security_groups = ["sg-04be052143c79bd66"]
  subnet_id = "subnet-5d85d427"
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = true
    encrypted = true
    kms_key_id = "d4faa181-32bd-48f4-987f-3fb9160caec7"
  }
  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
    encrypted = true
    kms_key_id = "d4faa181-32bd-48f4-987f-3fb9160caec7"
  }
  user_data =   <<-EOF
		#!/bin/bash
                sudo yum update -y
		sudo yum install -y httpd
		sudo systemctl start httpd
		sudo systemctl enable httpd
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
                EOF
  
  tags = {
    Name = "HelloWorld"
    Environment = "Dev"
  }
}
