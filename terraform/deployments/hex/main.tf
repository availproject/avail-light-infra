
data "digitalocean_project" "project" {
  name = "Lightclient-Hex"
}

module "bootnode" {
  source          = "../../modules/do"
  node_count      = 1
  image           = "ubuntu-22-04-x64"
  spec            = "c-8"
  node_type       = "bootnode"
  region          = "ams3"
  tags            = ["role:bootnode"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
}

module "otel" {
  source          = "../../modules/do"
  node_count      = 1
  image           = "ubuntu-22-04-x64"
  spec            = "c-8"
  node_type       = "otel"
  region          = "ams3"
  tags            = ["role:otel"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
}

module "lightnode" {
  source          = "../../modules/do"
  node_count      = 1
  image           = "ubuntu-22-04-x64"
  spec            = "c-16-intel"
  node_type       = "lightnode"
  region          = "ams3"
  tags            = ["role:lightnode"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
  
}

module "fatclient" {
  source          = "../../modules/do"
  node_count      = 1
  image           = "ubuntu-22-04-x64"
  spec            = "c-16-intel"
  node_type       = "fatclient"
  region          = "ams3"
  tags            = ["role:fatclient"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
}


data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")
  vars = {
    otel       = jsonencode(module.otel.droplets)
    bootnode   = jsonencode(module.bootnode.droplets)
    lightnodes = jsonencode(module.lightnode.droplets)
    fatclients = jsonencode(module.fatclient.droplets)
    network    = var.network
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/../../../ansible/inventory/${var.network}.ini"
}

variable "network" {
  default = "hex"
}

output "lightnodes" {
  value = module.lightnode.droplets
}

output "fatclients" {
  value = module.fatclient.droplets
}

output "otel" {
  value = module.otel.droplets
}

output "bootnode" {
  value = module.bootnode.droplets
}
