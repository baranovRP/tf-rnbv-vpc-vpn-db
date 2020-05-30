###
variable "vpn_client_cidr_block" {
  description = "The cidr block for vpn client"
  type        = string
  default     = "20.0.0.0/16"
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
