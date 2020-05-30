### Network infrastructure
### Create custom VPC with 3 private subnets
### Create security group to restrict access to postgresql instance
### Create db subnet group
### State saved remotely
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  required_version = "~> v0.12"

  backend "s3" {
    bucket = "tf-state-eu-central-1-ora2postgres"
    key    = "live/stage/network/vpc/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "tf-locks-eu-central-1-ora2postgres"
    encrypt        = true
  }
}

data "aws_availability_zones" "all" {
  all_availability_zones = true
}

resource "aws_vpc" "this" {
  cidr_block           = local.cidr_block_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name   = "o2p-vpc"
    Module = "vpc"
    Env    = "stage"
  }
}

resource "aws_subnet" "private_dbs" {
  count = length(local.private_cidr_blocks) > 0 ? length(local.private_cidr_blocks) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = local.private_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = {
    Name   = "o2p-sn-db-${local.subnet_sfx[count.index]}"
    Module = "vpc"
    Env    = "stage"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "o2p-db-sn-group"
  subnet_ids = tolist(aws_subnet.private_dbs.*.id)

  tags = {
    Name   = "o2p-db-sn-group"
    Module = "vpc"
    Env    = "stage"
  }
}

resource "aws_security_group" "postgres_sg" {
  name   = "o2p-sg-vpc"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name   = "o2p-postgres-sg"
    Module = "vpc"
    Env    = "stage"
  }
}
