provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "kaeptn-eichhorn" {
  ami = "ami-04bf6dcdc9ab498ca"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
