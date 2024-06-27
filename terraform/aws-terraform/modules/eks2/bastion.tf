# terraform {
#   required_version = "~> 1.0.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "aws" {
#   region = local.aws_region
# }

# terraform {
#   backend "s3" {
#     bucket         = "2024-dev-tf-state"
#     dynamodb_table = "2024-dev-tf-state-lock"
#     key            = "bastion"
#     region         = "us-east-1"
#   }
# }

# locals {
#   aws_region             = "us-east-1"
#   ami                    = "ami-080e1f13689e07408"
#   instance_type          = "t2.micro"
#   key_name               = "devops-key"
#   vpc_security_group_ids = ["sg-0dc47ff9f077ab787"]
#   subnet_id              = "subnet-0e0e8dbbbfab39bbf"
#   volume_size            = "10"

#   tags = {
#     Name = "bastion_host"
#   }
# }

# # create the AWS instance using the local variable
# resource "aws_instance" "bastion-host" {

#   ami                    = local.ami
#   instance_type          = local.instance_type
#   key_name               = local.key_name
#   vpc_security_group_ids = local.vpc_security_group_ids
#   subnet_id              = local.subnet_id

#   root_block_device {
#     volume_size = local.volume_size
#   }
#   associate_public_ip_address = true # Associate a public IP address

#   tags = local.tags
# }

# #   tags = {
# #     "id"             = "2024"
# #     "owner"          = "a1vincent"
# #     "teams"          = "PD"
# #     "environment"    = "dev"
# #     "project"        = "bastion-host"
# #     "create_by"      = "Terraform"
# #     "cloud_provider" = "aws"
# #   }

# # # Create bastion host EC2 instance
# # resource "aws_instance" "bastion_host" {
# #   ami             = "ami-080e1f13689e07408"                # Update with your desired AMI ID
# #   instance_type   = "t2.micro"                             # Update with your desired instance type
# #   key_name        = "devops-key"                           # Update with your key pair name
# #   subnet_id       = aws_subnet.vincent_public_subnet[0].id # Update with your subnet ID
# #   security_groups = [aws_security_group.bastion-sg.id]

# #   tags = merge(var.tags, {
# #     Name = "vincent_bastion_host"
# #   })

# #   associate_public_ip_address = true # Associate a public IP address
# # }
