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

resource "latitudesh_server" "server" {
  hostname         = "lightclient"
  operating_system = "ubuntu_22_04_x64_lts"
  plan             = var.plan                   # Uses the plan slug we defined on variables.tf
  project          = latitudesh_project.project.id   # Uses the project id we will create
  site             = var.site # You can use the site id or slug
  ssh_keys         = [latitudesh_ssh_key.ssh_key.id] # Uses the ssh id we will create. If you don't have an SSH key ready to use, you can remove this line and servers will be created with password auth instead
}

resource "latitudesh_ssh_key" "ssh_key" {
  project    = latitudesh_project.project.id # Uses the project id we will create
  name       = "lc_ssh" # Name your key so it's easy to identify later
  public_key = var.ssh_public_key
}

output "server-ip" {
  value = latitudesh_server.server.primary_ipv4
}