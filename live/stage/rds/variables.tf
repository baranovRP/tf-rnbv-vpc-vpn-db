locals {
  secretmanager_key   = "live/stage/rds"
  rds_database_name   = "ora2postgres"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  default     = "tf-state-eu-central-1-ora2postgres"
}

variable "vpc_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
  default     = "live/stage/network/vpc/terraform.tfstate"
}
