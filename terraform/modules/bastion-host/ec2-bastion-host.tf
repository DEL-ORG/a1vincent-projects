locals {
  aws_region             = "us-east-1"
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  key_name               = "devops-key"
  vpc_security_group_ids = ["sg-09897bf8c16106250"]
  subnet_id              = "subnet-0eaffc90855c49561"
  volume_size            = "10"

  tags = {
    Name = "bastion_host"
  }
}

# Create the AWS instance using the local variable
resource "aws_instance" "bastion_host" {
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.vpc_security_group_ids

  root_block_device {
    volume_size = local.volume_size
  }

  # Associate a public IP address with the instance
  associate_public_ip_address = true

  tags = local.tags
}
