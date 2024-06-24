variable "node_count" {
  type    = string
  default = "0"
}

variable "image" {
  default = "ubuntu-22-04-x64"
}

variable "network" {}
variable "node_type" {}
variable "region" {}
variable "spec" {}
variable "ssh_fingerprint" {}
variable "project" {}
variable "tags" {
  type    = list(string)
  default = []
}
