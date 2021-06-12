#!/bin/bash
sudo yum install -y httpd
sudo service httpd start
sudo chkconfig httpd on
#echo "Hello World!!" | /var/www/html/index.html
sudo touch /var/www/html/index.html
sudo chmod 777 /var/www/html/index.html
echo "Hello World!!" >> /var/www/html/index.html
