output "public_subnet_id" {
  description = "The ID of the subnet created"
  value       = aws_subnet.vincent_public_subnet[*].id
}

output "private_subnet_id" {
  description = "The ID of the subnet created"
  value       = aws_subnet.vincent_private_subnet[*].id
}

output "vpc_id" {
  description = "The ID of the VPC created"
  value       = aws_vpc.vincent_vpc.id
}

output "security_group_id" {
  description = "The ID of the security group created"
  value       = aws_security_group.bastion-sg.id
}

# Output the public IP address of the bastion host
output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}