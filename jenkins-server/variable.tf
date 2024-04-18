# Define variables
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type_master" {
  type    = string
  default = "t2.micro"
}

variable "instance_type_node" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-07761f3ae34c4478d"
}

variable "key_name" {
  type    = string
  default = "jenkins-new"
}

variable "jenkins_user_data" {
  type    = string
  default = <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y default-jre
sudo apt install -y wget
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins
sudo systemctl start jenkins
EOF
}

variable "jenkins_agent_secret" {
  type    = string
  default = "your_agent_secret_here"
}

variable "private_key_path" {
  type    = string
  default = "/path/to/your/private/key.pem"
}
