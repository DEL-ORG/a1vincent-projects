# Fetch VPC ID
data "aws_vpc" "main" {
  default = true
}

# Fetch subnet IDs for public subnets (where the bastion host will be launched)
data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet"] # Adjust the tag value according to your subnet naming convention
  }
}

# Fetch security group IDs (for SSH access to the bastion host)
data "aws_security_group" "bastion_security_group" {
  name = "bastion-security-group" # Adjust with the name of your security group
}

# Fetch AMI ID for the bastion host
data "aws_ami" "bastion_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["your-ami-name"] # Replace with the name of your AMI
  }
}



# data "aws_ami" "vincent-ami" {
#   most_recent = true
#   owners      = ["099720109477"]

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# data "aws_subnet" "vincent-subnet" {
#   id = "subnet-0eaffc90855c49561"
# }

# data "aws_security_group" "vincent-sg" {
#   id = "sg-09897bf8c16106250"
# }
