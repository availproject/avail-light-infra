# Determines the server configuration we are going to deploy
variable "plan" {
  description = "Latitude.sh server plan"
  default     = "m4-metal-medium"
}

# Determines the location we are going to deploy to
variable "site" {
  description = "Latitude.sh server region slug"
}

variable "ssh_public_key" {
  description = "Latitude.sh SSH public key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChcBsNncTYvSwIJoyFnxmvaJP196JYK7tTkZiFZH1nIZo0G0N5y0V2KVNmF0KcQAWQHr7az5nfOZ1d5nSmAn8FrDAA6Q0qSCGOTtOS4b5fAZwseb4qcN89wZrqiv2sgYgaE+25UK1iHQhrBR9dqZj5rIEZcKv5OzSMLmbfvtbu05yG7sCvXTmPAlAcB9AoN3hsI6cJtjxZ2Jj18mKuBHaqmEb7pvRweNirbzdRpabgfb+9DX4d4RYeGdd+kXHt9nRjaSP4bitE1qbNSln5wNkMb10LZMhYhxmCnWcp9QiOrPA4rywCaXBSL0+s7AKUhskSWoYIeC2F/ZI4E6Ahcl72atFlRhBx8s0v+aE0dG+Nps1Y+JcqBbC4luPVSASbNY6HhUnU1VZ73zAcMJZreHHyZBkj25uwpbIz+GUZD/+c6AmNMKkIg28dszriO9OWpbvi14bqVe/Dl9a4xLIBLZAbCrcRU18m7fMaTi/aN3WlMBZAaGvhksVD63ITuR6HlRM= ob@obs-iMac"
}
