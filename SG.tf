resource "aws_security_group" "PublicSG" {
  name        = "Public-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.capstone.id

  tags = {
    Name = "Public-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "publicinbound" {
  security_group_id = aws_security_group.PublicSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "publicinbound2" {
  security_group_id = aws_security_group.PublicSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "publicinbound3" {
  security_group_id = aws_security_group.PublicSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "publicoutbound" {
  security_group_id = aws_security_group.PublicSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "PrivateSG" {
  name        = "Private-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.capstone.id

  tags = {
    Name = "Private-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "privateinbound" {
  security_group_id = aws_security_group.PrivateSG.id
  cidr_ipv4         = "10.100.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "privateoutbound" {
  security_group_id = aws_security_group.PrivateSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

