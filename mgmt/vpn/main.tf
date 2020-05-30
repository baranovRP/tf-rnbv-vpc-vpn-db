### Create VPN
### State saved remotely
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  required_version = "~> v0.12"

  backend "s3" {
    bucket = "tf-state-eu-central-1-ora2postgres"
    key    = "mgmt/vpn/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tf-locks-eu-central-1-ora2postgres"
    encrypt        = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_remote_state_bucket
    key    = var.vpc_remote_state_key
    region = var.region
  }
}

module "auth" {
  source = "../../modules/security/auth"

  server_domain = "vpnlive.com"
  user_domain   = "user.vpnlive.com"
}

module "vpn" {
  source = "../../modules/network/vpn"

  description            = "o2p-vpn-client"
  client_cidr_block      = var.vpn_client_cidr_block
  server_certificate_arn = module.auth.server_certificate_arn
  subnet_ids             = data.terraform_remote_state.vpc.outputs.subnet_ids
  user_certificate_arn   = module.auth.user_certificate_arn
  vpc_cidr_block         = data.terraform_remote_state.vpc.outputs.cidr_block
}
