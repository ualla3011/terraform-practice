data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.PublicSG.id]
  key_name = aws_key_pair.kp.key_name
  associate_public_ip_address = true

  tags = {
    Name = "app"
  }
}

resource "aws_instance" "tools" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.PublicSG.id]
  key_name = aws_key_pair.kp.key_name
  associate_public_ip_address = true

  tags = {
    Name = "tools"
  }
}

resource "aws_eip" "static_ip" {
  instance = aws_instance.app.id
  vpc = true
}

output "pub_stat_ip" {
value = aws_eip.static_ip.pub_stat_ip
}


