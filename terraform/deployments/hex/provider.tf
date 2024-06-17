terraform {
  backend "s3" {
    bucket = "do-avail-light-tfstate"
    key    = "hex"
    region = "eu-west-1"
  }
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34.1"
    }
  }
  required_version = ">= 1.6.0"

}

provider "aws" {
  region = "eu-west-1"
}


