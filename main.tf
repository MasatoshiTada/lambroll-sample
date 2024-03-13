terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "Dev-App-PictoPass"
}
