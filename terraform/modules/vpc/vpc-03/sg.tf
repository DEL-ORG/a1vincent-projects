resource "aws_security_group" "bastion-sg" {
  name        = "bastion-host"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vincent_vpc.id

  tags = merge(var.tags, {
    Name = "bastion-host-sg"
  })
}


resource "aws_security_group_rule" "allow_all_ingress" {
  security_group_id = aws_security_group.bastion-sg.id
  type              = "ingress" # Specifies ingress traffic
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Allow traffic from any IP address
}

resource "aws_security_group_rule" "allow_all_egress" {
  security_group_id = aws_security_group.bastion-sg.id
  type              = "egress" # Specifies egress traffic
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] # Allow traffic to any IP address
}
