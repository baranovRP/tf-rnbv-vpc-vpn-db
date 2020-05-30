output "rds_database_name" {
  description = "Name of created rds"
  value       = aws_db_instance.this.name
}

output "rds_master_password" {
  description = "The master password"
  value       = aws_db_instance.this.password
  sensitive   = true
}

output "rds_port" {
  description = "The rds port"
  value       = aws_db_instance.this.port
}

output "rds_master_username" {
  description = "The rds master username"
  value       = aws_db_instance.this.username
}

output "rds_endpoint" {
  description = "The rds endpoint"
  value       = aws_db_instance.this.endpoint
}
