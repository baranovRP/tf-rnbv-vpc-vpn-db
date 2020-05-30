locals {
  private_cidr_blocks = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  subnet_sfx          = ["a", "b", "c"]
  cidr_block_vpc      = "10.0.0.0/16"
}

variable "region" {
  description = "Region in which to create dev environment."
  type        = string
  default     = "eu-central-1"
}
