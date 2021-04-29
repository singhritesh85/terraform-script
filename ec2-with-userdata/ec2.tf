resource "aws_instance" "web"  {
count = "${var.web_count}"
ami = "${var.web_ami[var.region]}"
instance_type = "${var.web_instance_type[0]}"
subnet_id = "${var.provide_subnet_id[count.index]}"
user_data =     <<-EOT
                #!/bin/bash
                yum install httpd -y
                service httpd start
                chkconfig httpd on
                echo "<h1>This is a sample website.</h1>" >> /var/www/html/index.html
                
                /usr/sbin/useradd -s /bin/bash -m ritesh;
                mkdir /home/ritesh/.ssh;
                chmod -R 700 /home/ritesh;
                echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJlKY/Wv7MMhv0sMnkQ863LyOUn9sptj/H3lU2w3Dos/KkoLUVqvGLIT6wF0muuZkJp4F0/kkvgwS6upfghdIUmqsNhlIGvczLF9+Ht4tR5YD12pw9zN4NcikT667VqKJeVM83NLeOX8imgca2rbUjSUOO2sjgLJa60/PQkcKiMFAfbMYkE2tYTQCW5s3AfoJB/7wPg/X+bcLwGJjTwwGtXF5NcgJ0um8qCdoXzD6dMeApJeUq73qez9oqz9c+p9VoPkWgxV+A5OyNup1ydCxqte7eJGt6ay0/fTtm4nT9j0GAnnaH31kt9V6W4xJxKRjW2syJ6KJpBXmt4ZLnDbGq8nTDN/7z6dMWR7Ai2pAGgYcMZcizVK8wx5GG9C4+kQR1nRVVqhB1bdWJjXVIUGnry826qnrtImJyFvtrAuFQXsnC2noBp+0aCLeFNT9TtxDwZLGJ33xgrPcVvCyxL8rlUyxrIMH8CGXRXAIgDRv3Nu0CTp6q8IkCNt+ZzGC6//U= ritesh@DESKTOP-2UQTKO7" >> /home/ritesh/.ssh/authorized_keys;
                chmod 600 /home/ritesh/.ssh/authorized_keys;
                chown ritesh:ritesh /home/ritesh/.ssh -R;
                echo "ritesh  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/ritesh;
                chmod 440 /etc/sudoers.d/ritesh;
             EOT

key_name = "key"
                
tags = {
   Name = "Instance-${count.index+1}"
   Environment = "${terraform.workspace}"
}
}
