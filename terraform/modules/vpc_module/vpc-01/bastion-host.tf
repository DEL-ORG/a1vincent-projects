# Create bastion host EC2 instance
resource "aws_instance" "bastion_host" {
  ami             = "ami-07d9b9ddc6cd8dd30"                # Update with your desired AMI ID
  instance_type   = "t2.micro"                             # Update with your desired instance type
  key_name        = "jenkins-master"                       # Update with your key pair name
  subnet_id       = aws_subnet.vincent_public_subnet[0].id # Update with your subnet ID
  security_groups = [aws_security_group.bastion-sg.id]

  tags = merge(var.tags, {
    Name = "vincent_bastion_host"
  })

  associate_public_ip_address = true # Associate a public IP address
}


