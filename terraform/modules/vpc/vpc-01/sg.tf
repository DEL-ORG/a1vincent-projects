resource "aws_security_group" "ec2-private" {
  name        = "ec2-private"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = "ec2-private-sg"
  })
}


resource "aws_security_group_rule" "allow_all_ingress" {
  security_group_id = aws_security_group.ec2-private-sg.id
  type              = "ingress" # Specifies ingress traffic
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Allow traffic from any IP address
}

# resource "aws_security_group_rule" "allow_all_egress" {
#   security_group_id = aws_security_group.bastion-sg.id
#   type              = "egress" # Specifies egress traffic
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"] # Allow traffic to any IP address
# }