### Postgres DataBase
### Create postgresql
### State saved remotely
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  required_version = "~> v0.12"

  backend "s3" {
    bucket = "tf-state-eu-central-1-ora2postgres"
    key    = "live/stage/rds/terraform.tfstate"
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

data "aws_availability_zones" "available" {
  state = "available"
}

module "secret" {
  source = "../../../modules/security/secret"

  secret_name = local.secretmanager_key
}

resource "aws_db_instance" "this" {
  allocated_storage      = 15
  max_allocated_storage  = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "9.6.9"
  instance_class         = "db.t2.micro"
  name                   = local.rds_database_name
  username               = module.secret.secret_json["rds_user"]
  password               = module.secret.secret_json["rds_passw"]
  parameter_group_name   = "default.postgres9.6"
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_name
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.postgres_sg]
  skip_final_snapshot    = true

  tags = {
    Name   = "o2p-rds"
    Module = "rds"
    Env    = "stage"
  }
}
