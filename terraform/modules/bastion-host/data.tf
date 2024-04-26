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
  id = "subnet-0eaffc90855c49561"
}

data "aws_security_group" "vincent-sg" {
  id = "sg-09897bf8c16106250"
}
