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
 