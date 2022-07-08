resource "aws_instance" "foo" {
  ami           = var.provide_ami
  instance_type = var.instance_type
  monitoring = true
  security_groups = var.security_groups
  subnet_id = var.subnet_id
  root_block_device{
    volume_type="gp2"
    volume_size="20"
    encrypted=true
    kms_key_id="arn:aws:kms:us-east-2:694148179922:key/6e205831-79a4-49ce-9368-621ccbe930cd"
    delete_on_termination=true
  }
  user_data=<<EOF
                 #!/bin/bash
                 /usr/sbin/useradd -s /bin/bash -m ritesh;
                 mkdir /home/ritesh/.ssh;
                 chmod -R 700 /home/ritesh;
                 echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB505AFZTdRbtHcT3PT2mEbTY/ppekzIoob5fawyCiaPs+RXZhrl9lcIx4aKcueoADUN/3BUb1sS+xe27HoO1AoOIm/6owU7sou9K1Qr7rxgvRGI8/30mVC+tIKJjAgfusEMmD7XMgkzNCfJveyb944jKT6SVae/EmcadVUc65SFCvPNcsb+NFaeidJxr9d1ZsGrkl0wD7PLVSkdTJI3JAMP4ACs497LT7Vbv7ceMqEFzkUZQZAqoMHi9aUIVbcMySmHO7RNBk5Z8BSzx/f0kjJzp8X+JoGFXiTxRx8VQntr6WP72O794zb6dR33O2mclfeZ7lXHUFYgdLMWX2ukgO9utTkKOjpHQTGjcFvie1cgrli4ninzyMbE1z1zaWfpqy1JIJ0LPH6d7t+C2U3HABB6Ml5UL++MF/2muwESzr1CIxAXUd+x9Sv9Rqb8ahSSFTOGEshU/NoVCJLKVAiP+5YgIhyHLLMpwHcTG7wC5D/TABkhbMC7DLnMqsNWykU0c= ritesh@DESKTOP-02A84PF" >> /home/ritesh/.ssh/authorized_keys;
                 chmod 600 /home/ritesh/.ssh/authorized_keys;
                 chown ritesh:ritesh /home/ritesh/.ssh -R;
                 echo "ritesh  ALL=(ALL)  NOPASSWD:ALL" > /etc/sudoers.d/ritesh;
                 chmod 440 /etc/sudoers.d/ritesh; 

                 yum install -y httpd
                 service httpd start
                 echo "Hello All" >> /var/www/html/index.html
                 chkconfig httpd on
             EOF
  lifecycle{
    prevent_destroy=false
    ignore_changes=[ ami ]
  }
  tags={
    Name=var.name
    Environment = var.env
  }
}
resource "aws_eip" "eip_associate" {
  instance = aws_instance.foo.id
  vpc = true
}
