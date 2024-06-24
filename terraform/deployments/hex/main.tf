
data "digitalocean_project" "project" {
  name = "Lightclient Hex"
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
  node_count      = 2
  image           = "ubuntu-22-04-x64"
  spec            = "c-32-intel"
  node_type       = "lightnode"
  region          = "ams3"
  tags            = ["role:lightnode"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
  
}

module "fatclient" {
  source          = "../../modules/do"
  node_count      = 2
  image           = "ubuntu-22-04-x64"
  spec            = "c-32-intel"
  node_type       = "fatclient"
  region          = "ams3"
  tags            = ["role:fatclient"]
  network         = var.network
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project      = data.digitalocean_project.project
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