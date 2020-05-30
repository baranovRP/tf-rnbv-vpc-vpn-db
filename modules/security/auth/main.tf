###
data "aws_acm_certificate" "server" {
  domain = var.server_domain
}

data "aws_acm_certificate" "user" {
  domain = var.user_domain
}
