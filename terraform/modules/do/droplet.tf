locals {
  network   = var.network
}

resource "digitalocean_droplet" "droplet" {
  count  = var.node_count
  image  = var.image
  name   = format("%s-%02d-%s", var.node_type, count.index + 1, local.network)
  region = var.region
  size   = var.spec
  droplet_agent = true
  monitoring    = true
  ssh_keys = var.ssh_fingerprint
  tags    = concat([format("network:%s", var.network)], var.tags)
}

resource "digitalocean_project_resources" "project_resource" {
  project   = var.project.id
  resources = [for d in digitalocean_droplet.droplet : d.urn]
}

resource "digitalocean_reserved_ip" "reserved_ip" {
  count      = var.node_count
  region     = var.region
  droplet_id = digitalocean_droplet.droplet[count.index].id
}

output "droplets" {
  value = [
    for instance in digitalocean_droplet.droplet :
    {
      hostname = instance.name
      ip       = instance.ipv4_address
    }
  ]
}