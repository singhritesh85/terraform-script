resource "aws_key_pair" "deployer_key" {
  key_name   = "terraform_key"
  public_key = "ssh-rsa AAAXXXXXXXXXXXXXXXXXXXX6/ZXX/vttXXXXXXXXXXXXXXXXXXXXXX61SXXXXiIjXXXXXXXXXXf7Oewnn2XXXXXXXXXXXXXXXXXXXXXXSJ8RF9GP3NqRAeV3qJ/HFflWNy0hikFtiqNBf4MyenX+KhsUrssvyyrkxZMRqREC4OOojlRleEozezboTe1D55unEw37tFT0vi1NCJ52vgtaka9WKobrSubbl8rJcCPfozBA8cWB/7mvMkWX6JAjyZsKuPeMuOJCnbkzRPk/4PXARNEsXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXTSzIvsPkVt root@terraform-server"
}

resource "aws_instance" "demo_instance" {           ###  Answer for Question 1
  ami           = var.provide_ami
  instance_type = var.instance_type
  key_name = "terraform_key"
#  iam_instance_profile = aws_iam_instance_profile.ec2_iam_profile.name  
  monitoring = true
  security_groups = var.security_group
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:us-east-2:XXXXXXXXXXXXXXXX:key/XXXXXXX-9XXX-4XXX-XXXX-8XXXXXXXXXXXXXX9"
  }
  user_data =   <<-EOF
                #!/bin/bash
                /usr/sbin/useradd -s /bin/bash -m ritesh;
                mkdir /home/ritesh/.ssh;
                chmod -R 700 /home/ritesh;
                echo "ssh-rsa AAXXB3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXsptj/HXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXF0/kkvgwS6upfgXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXikT667VqKJeVM83NXXXXXXXXXXXXXXXXXXXXXjgLJa60/PQXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXs3AfoJB/7wPg/X+bcLwGJjTwwGtXF5NcgJ0um8qCdoXzD6dMeApJeUq73qez9oqz9c+p9VoPkWgxV+A5OyNup1ydCxqte7eJGt6ay0/fTtm4nT9j0GAnnaH3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXC4+kQR1nRVVqhB1bdWJjXVIUGnry8XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXGC6//U= ritesh@DESKTOP-2UQTKO7" >> /home/ritesh/.ssh/authorized_keys;
                chmod 600 /home/ritesh/.ssh/authorized_keys;
                chown ritesh:ritesh /home/ritesh/.ssh -R;
                echo "ritesh  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/ritesh;
                chmod 440 /etc/sudoers.d/ritesh;
                EOF
  lifecycle {
    prevent_destroy = false
}
  tags = {
    Name = var.instance_name
    Environment = var.environment
  }
  
  provisioner "file" {
    source    = "playbook.yaml"
    destination = "/tmp/playbook.yaml"
  }

  provisioner "remote-exec" {
    inline = [
                "sudo amazon-linux-extras install ansible2 -y",
                "sudo yum install git -y",
                "sudo mkdir /home/project-path",
                "cd /home/project-path",
                "sudo git clone https://github.com/kamalmohan217/hello-world-1.git",
                "sudo cp /tmp/playbook.yaml /home/project-path/hello-world-1"
    ]
  }

  provisioner "remote-exec" {
    inline = [ 
               "cd /home/project-path/hello-world-1",
               "sudo ansible-playbook -i ${aws_instance.demo_instance.public_ip} --private-key terraform_key playbook.yaml"
    ]
  }

  connection {
    user = "ec2-user"
    private_key = file("/home/ec2-user/terraform_key.pem")
    host = aws_instance.demo_instance.public_ip
  }

}

  resource "aws_eip" "eip_associate" {
  instance = aws_instance.demo_instance.id
  vpc      = true
}


#Application Loadbalancer                   #######  Answer for Question 2
resource "aws_lb" "test-application-loadbalancer" {
  name               = var.application_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_group
  subnets            = var.subnets     

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout = var.idle_timeout

  tags = {
    Environment = var.environment
  }
}

#Target Group of Application Loadbalancer
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.instance_port      
  protocol = var.instance_protocol  
  vpc_id   = var.vpc_id
  target_type = var.target_type_alb[0]
  load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}

##Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "alb_listener_front_end_HTTP" {
  load_balancer_arn = aws_lb.test-application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.type[1]
    target_group_arn = aws_lb_target_group.target_group.arn
     redirect {    ### Redirect HTTP to HTTPS
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "alb_listener_front_end_HTTPS" {
  load_balancer_arn = aws_lb.test-application-loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy[0]
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

## EC2 Instance attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.demo_instance.id
  port             = 80
}
