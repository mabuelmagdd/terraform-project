terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"  # or the version you need
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}