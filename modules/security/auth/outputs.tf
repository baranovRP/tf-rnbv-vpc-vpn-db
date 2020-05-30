output "user_certificate_arn" {
  value = data.aws_acm_certificate.user.arn
}

output "server_certificate_arn" {
  value = data.aws_acm_certificate.server.arn
}
