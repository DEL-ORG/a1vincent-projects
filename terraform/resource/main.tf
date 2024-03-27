provider "aws" {
  region = "us-east-1"
}

# Generates a secure private k ey and encodes it as PEM
resource "tls_private_key" "terraform-project" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Create the Key Pair
resource "aws_key_pair" "terraform-project" {
  key_name   = "privatekeypair"
  public_key = tls_private_key.terraform-project.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "terraform-project.pem"
  content  = tls_private_key.terraform-project.private_key_pem
}

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "example_sg" {
  name        = "terraform1-sg"
  description = "Allow inbound SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "us-east-1b" # Replace with the desired availability zone
  map_public_ip_on_launch = true
}

resource "aws_instance" "example_instance" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.terraform-project.key_name
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  subnet_id              = aws_subnet.example_subnet.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup python -m SimpleHTTPServer 80 &
              EOF
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.example_instance.public_ip
}

output "ssh-command" {
  value = "ssh -i terraform-project.pem ubuntu@${aws_instance.example_instance.public_dns}"
}
