locals {
  project    = "aws-ipsec-vpn"
  region     = var.region
  account_id = data.aws_caller_identity.current.account_id
  log_level = "info"
}

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}
