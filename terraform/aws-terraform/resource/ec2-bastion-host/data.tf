data "aws_ami" "vincent-ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_subnet" "vincent-subnet" {
  id = "subnet-065127e56675202bd"
}

data "aws_security_group" "vincent-sg" {
  id = "sg-049930813ac5125bc"
}