data "digitalocean_project" "project" {
  name = "Infrastructure"
}

module "otel" {
  source          = "../../../modules/do"
  node_count      = 1
  image           = "ubuntu-22-04-x64"
  spec            = "c-8"
  node_type       = "otel"
  region          = "ams3"
  tags            = ["role:otel", "owner:devops", "customer:sophon", "Infrastructure", "domain:metrics"]
  network         = var.customer
  ssh_fingerprint = [digitalocean_ssh_key.key.fingerprint]
  project         = data.digitalocean_project.project
}

data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")
  vars = {
    otel     = jsonencode(module.otel.droplets)
    customer = var.customer
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/../../../../ansible/inventory/${var.customer}.ini"
}

variable "customer" {
  default = "sophon"
}

output "otel" {
  value = module.otel.droplets
}
