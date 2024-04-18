# Launch an EC2 instance for Jenkins master
resource "aws_instance" "jenkins_master" {
  ami             = var.ami
  instance_type   = var.instance_type_master
  key_name        = var.key_name
  security_groups = [aws_security_group.gymef_jenkins_sg.name]
  user_data       = var.jenkins_user_data

  tags = {
    Name = "jenkins-master"
  }

  # Provision Jenkins on the master instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y default-jre",
      "sudo apt install -y wget",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"                   # or whatever user is appropriate for your AMI
      private_key = file(var.private_key_path) # path to your private key file
      host        = self.public_ip             # use "self" to refer to the instance itself
    }
  }
}

# Launch an EC2 instance for Jenkins dynamic node
resource "aws_instance" "jenkins_node" {
  ami             = var.ami
  instance_type   = var.instance_type_node
  key_name        = var.key_name
  security_groups = [aws_security_group.gymef_jenkins_sg.name]
  user_data       = var.jenkins_user_data

  tags = {
    Name = "jenkins-node"
  }
}

# provider "aws" {
#   region = "us-east-1" # Change this to your desired AWS region
# }

# # Jenkins Master Instance
# resource "aws_instance" "jenkins_master" {
#   ami                         = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI, replace with your preferred AMI
#   instance_type               = "t2.micro"              # Change this to your preferred instance type
#   key_name                    = "your-key-pair"         # Replace with your AWS key pair
#   security_groups             = ["jenkins-master-sg"]   # Make sure you define this security group with proper rules
#   associate_public_ip_address = true

#   tags = {
#     Name = "jenkins-master"
#   }
# }

# # Jenkins Node Instance
# resource "aws_instance" "jenkins_node" {
#   ami                         = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI, replace with your preferred AMI
#   instance_type               = "t2.micro"              # Change this to your preferred instance type
#   key_name                    = "your-key-pair"         # Replace with your AWS key pair
#   security_groups             = ["jenkins-node-sg"]     # Make sure you define this security group with proper rules
#   associate_public_ip_address = true

#   tags = {
#     Name = "jenkins-node"
#   }
# }

# # Example Security Group for Jenkins Master
# resource "aws_security_group" "jenkins-master-sg" {
#   name        = "jenkins-master-sg"
#   description = "Security group for Jenkins Master"

#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Example Security Group for Jenkins Node
# resource "aws_security_group" "jenkins-node-sg" {
#   name        = "jenkins-node-sg"
#   description = "Security group for Jenkins Node"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
