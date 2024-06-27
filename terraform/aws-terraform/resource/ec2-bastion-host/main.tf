# Create bastion host EC2 instance
resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.vincent-ami.id       # Update with your desired AMI ID
  instance_type          = "t2.micro"                        # Update with your desired instance type
  key_name               = "devops-key"                      # Update with your key pair name
  subnet_id              = data.aws_subnet.vincent-subnet.id # Update with your subnet ID
  vpc_security_group_ids = [data.aws_security_group.vincent-sg.id]
  tags = merge(var.tags, {
    Name = "vincent_bastion_host1"
  })
  associate_public_ip_address = true # Associate a public IP address
}



terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "2024-dev-tf-state"
    dynamodb_table = "2024-dev-tf-state-lock"
    key            = "bastion-host"
    region         = "us-east-1"
  }
}

locals {
  aws_region    = "us-east-1"
  instance_type = "t2.micro"
  key_name      = "devops-key"
  volume_size   = "10"
  tags = {
    "id"             = "2024"
    "owner"          = "a1vincent"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "bastion"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "ec2" {
  source        = "../../../modules/ec2-bastion-host"
  aws_region    = local.aws_region
  instance_type = local.instance_type
  key_name      = local.key_name
  volume_size   = local.volume_size
  tags          = local.tags
}

# subnet_id              = local.subnet_id
# vpc_security_group_ids = ["sg-024b24ef8d2f0ddd7"]
# subnet_id              = "subnet-0a5ea96bbd402cd1c"
# ami                    = "ami-080e1f13689e07408"
# ami                    = local.ami
# vpc_security_group_ids = local.vpc_security_group_ids

#   tags = {
#     "id"             = "2024"
#     "owner"          = "a1vincent"
#     "teams"          = "PD"
#     "environment"    = "dev"
#     "project"        = "bastion-host"
#     "create_by"      = "Terraform"
#     "cloud_provider" = "aws"
#   }

# # Create bastion host EC2 instance
# resource "aws_instance" "bastion_host" {
#   ami             = "ami-080e1f13689e07408"                # Update with your desired AMI ID
#   instance_type   = "t2.micro"                             # Update with your desired instance type
#   key_name        = "devops-key"                           # Update with your key pair name
#   subnet_id       = aws_subnet.vincent_public_subnet[0].id # Update with your subnet ID
#   security_groups = [aws_security_group.bastion-sg.id]

#   tags = merge(var.tags, {
#     Name = "vincent_bastion_host"
#   })

#   associate_public_ip_address = true # Associate a public IP address
# }

