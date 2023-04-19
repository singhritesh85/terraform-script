####################################################################
region = "us-east-2"
provide_ami = {
    us-east-1 = "ami-04d29b6fXXXXXXXXX"
    us-east-2 = "ami-09558250XXXXXXXXX"
    us-west-1 = "ami-08d9a394XXXXXXXXX"
    us-west-2 = "ami-0e472933XXXXXXXXX"
}
instance_type = ["t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge"]
security_group = [ "sg-038894a2XXXXXXXX" ]
subnet_id = "subnet-XXXXXXXXXX"
instance_name = "Tomcat-Server"
environment = "uat"
