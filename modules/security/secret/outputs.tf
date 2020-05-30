###
output "secret_json" {
  description = "The secret string as json"
  value       = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)
}
