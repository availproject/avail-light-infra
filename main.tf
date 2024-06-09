terraform {
  required_providers {
    latitudesh = {
      source  = "latitudesh/latitudesh"
      version = "1.0.0"
    }
  }
}

provider "latitudesh" {
  auth_token = "5d5c4cdba48ef403f2ec9a60810ad1c1f54e"
}

# Creates our project
resource "latitudesh_project" "project" {
  name        = "Lightclient"
  description = "Lightclient Deployment Project"
  environment = "Development"
}

# Define server resource dynamically for lightnodes, bootnodes, and fatclients
resource "latitudesh_server" "lightnode" {
  count            = var.lightnode_count
  hostname         = "lightnode-${count.index + 1}-lightclient-turing"
  operating_system = "ubuntu_22_04_x64_lts"
  plan             = var.plan
  project          = latitudesh_project.project.id
  site             = var.site
  ssh_keys         = [latitudesh_ssh_key.ssh_key.id]
}


resource "latitudesh_ssh_key" "ssh_key" {
  project    = latitudesh_project.project.id # Uses the project id we will create
  name       = "lc_ssh" # Name your key so it's easy to identify later
  public_key = var.ssh_public_key
}

output "server-ip" {
  value = latitudesh_server.server.primary_ipv4
}

# Output server details
output "lightnodes" {
  value = [for i in range(var.lightnode_count) : {
    hostname = latitudesh_server.lightnode[i].hostname
    ip       = latitudesh_server.lightnode[i].primary_ipv4
  }]
}

output "fatclients" {
  value = [for i in range(var.fatclient_count) : {
    hostname = latitudesh_server.fatclient[i].hostname
    ip       = latitudesh_server.fatclient[i].primary_ipv4
  }]
}