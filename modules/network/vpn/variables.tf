###
variable "server_certificate_arn" {
  description = "The server's certificate arn"
  type        = string
}

variable "user_certificate_arn" {
  description = "The user's certificate arn"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The cidr block of destination vpc"
  type        = string
}

variable "client_cidr_block" {
  description = "The client cidr block"
  type        = string
}

variable "subnet_sfx" {
  description = "The list of az suffixes"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "The list of subnet ids"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "The description of vpn client endpoint"
  type        = string
  default     = ""
}
