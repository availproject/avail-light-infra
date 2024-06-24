
locals {
  network = "hex"
}

resource "latitudesh_project" "lightclient" {
  name        = "Lightclient Hex Network"
  description = "Lightclient Hex Network"
  environment = "Development"
}

resource "latitudesh_ssh_key" "ssh_key" {
  project    = latitudesh_project.lightclient.id
  name       = "${local.network}"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "latitudesh_server" "this" {
  hostname         = "lightnode-${local.network}"
  operating_system = "ubuntu_22_04_x64_lts"
  plan             = var.plan                  
  project          = latitudesh_project.lightclient.id 
  site             = var.site
  ssh_keys         = [latitudesh_ssh_key.ssh_key.id]
}

output "ip" {
  value = latitudesh_server.this.primary_ipv4
}
