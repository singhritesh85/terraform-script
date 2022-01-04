resource "aws_security_group" "ec2_sg_loadbalancer" {
  name = "web-node-loadbalancer"
  description = "Web Security Group"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }    
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2_instance_loadbalancer" {
  count = var.count_no_loadbalancer
  ami           = var.amis
  instance_type = var.instance_type
  key_name = ""
  monitoring = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name 
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id     = var.subnet_id  
  security_groups = [ aws_security_group.ec2_sg_loadbalancer.id ]
  root_block_device  {
    delete_on_termination = true
    encrypted = true
    volume_type = var.volume_type
    volume_size = var.volume_size
    kms_key_id = var.kms_key_id   
  }
  user_data =     <<-EOT
                  #!/bin/bash
                  yum install -y awscli nfs-common cifs-utils 
                  sed -i '0,/PasswordAuthentication no/s//PasswordAuthentication yes/' /etc/ssh/sshd_config
                  service sshd reload 
                  echo "unix" | passwd root --stdin
               EOT

  tags = {
    Name = "${var.loadbalancer_name}${count.index}"
  }
  depends_on = [ aws_iam_role_policy.iam_policy, aws_iam_role.iam_role, aws_iam_instance_profile.ec2_profile ]
}
resource "aws_security_group" "ec2_sg_master" {
  name = "web-node-master"
  description = "Web Security Group"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2_instance_master" {
  count = var.count_no_master
  ami           = var.amis
  instance_type = var.instance_type
  key_name = ""
  monitoring = true
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id     = var.subnet_id
  security_groups = [ aws_security_group.ec2_sg_master.id ]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"    ##  Attach IAM Role to the EC2 Instance
  root_block_device  {
    delete_on_termination = true
    encrypted = true
    volume_type = var.volume_type
    volume_size = var.volume_size
    kms_key_id = var.kms_key_id
  }
  user_data =     <<-EOT
                  #!/bin/bash
                  yum install -y awscli nfs-common cifs-utils
                  sed -i '0,/PasswordAuthentication no/s//PasswordAuthentication yes/' /etc/ssh/sshd_config
                  service sshd reload
                  echo "unix" | passwd root --stdin
               EOT


  tags = {
     Name = "${var.master_name}${count.index}"
  }
}

resource "aws_security_group" "ec2_sg_worker" {
  name = "web-node-worker"
  description = "Web Security Group"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2_instance_worker" {
  count = var.count_no_worker
  ami           = var.amis
  instance_type = var.instance_type
  key_name = ""
  monitoring = true
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id     = var.subnet_id
  security_groups = [ aws_security_group.ec2_sg_worker.id ]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"  ## Attach IAM Role to the EC2 Instance
  root_block_device  {
    delete_on_termination = true
    encrypted = true
    volume_type = var.volume_type
    volume_size = var.volume_size
    kms_key_id = var.kms_key_id
  }
  user_data =      <<-EOT
                   #!/bin/bash
                   yum install -y awscli nfs-common cifs-utils
                   sed -i '0,/PasswordAuthentication no/s//PasswordAuthentication yes/' /etc/ssh/sshd_config
                   service sshd reload
                   echo "unix" | passwd root --stdin
                EOT 

  tags = {
    Name = "${var.worker_name}${count.index}"
  }
}

data "template_file" "inventory" {
  template = "${file("${path.module}/hosts.tmpl")}"

  vars = {
    master_private_ip_0 = "${aws_instance.ec2_instance_master.0.private_ip}"
    master_private_ip_1 = "${aws_instance.ec2_instance_master.1.private_ip}"
    master_private_ip_2 = "${aws_instance.ec2_instance_master.2.private_ip}"
    loadbalancer_private_ips = "${join("\n", aws_instance.ec2_instance_loadbalancer.*.private_ip)}"
    worker_private_ips = "${join("\n", aws_instance.ec2_instance_worker.*.private_ip)}"   
  }
}


resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers = {
    template = data.template_file.inventory.rendered
  }
}
