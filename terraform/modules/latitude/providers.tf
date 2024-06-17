terraform {
  required_providers {
    latitudesh = {
      source  = "latitudesh/latitudesh"
      version = "1.0.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "latitudesh" {
  auth_token = var.latitude_auth_token
}