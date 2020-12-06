provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "kaeptn-eichhorn" {
  ami = "ami-0b0f4c27376f8aa79"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
