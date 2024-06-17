
data "aws_ssm_parameter" "do_token" {
  name            = "do_token"
  with_decryption = true
}

provider "digitalocean" {
  token = data.aws_ssm_parameter.do_token.value
}

module "lightnode" {
  source          = "../../modules/do"
  node_count      = 2
  image      = "ubuntu-22-04-x64"
  spec       = "c-32-intel"
  node_type       = "lightnode"
  region          = "ams3"
  tags       = ["role:lightnode"]
  network = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")
  vars = {
    lightnodes = jsonencode(module.lightnode.droplets)
    network = var.network
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/../../../ansible/inventory/${var.network}.ini"
}

variable "network" {
  default = "hex"
}

output "droplets" {
  value = module.lightnode.droplets
}
