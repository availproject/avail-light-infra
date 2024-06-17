resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_ssm_parameter" "private_keypair" {
  name        = "/lightclient/${var.network}/private_keypair"
  description = "Private Keypair"
  type        = "SecureString"
  value       = tls_private_key.pk.private_key_pem
}

resource "digitalocean_ssh_key" "key" {
  name       = "lc-ssh-key-${var.network}"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  content  = tls_private_key.pk.private_key_pem
  filename = "${path.module}/../../../ansible/${var.network}_key"
}
