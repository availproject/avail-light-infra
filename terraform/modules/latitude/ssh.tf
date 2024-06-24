resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "network" {
  key_name   = "keypair-${local.network}"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "aws_ssm_parameter" "private_keypair" {
  name        = "/latitude/lightclient/${local.network}/private_keypair"
  description = "Public Keypair"
  type        = "SecureString"
  value       = tls_private_key.pk.private_key_pem
}