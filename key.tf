resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "project"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.pk.private_key_pem
  sensitive = true
}

