###
output "vpc_id" {
  description = "The VPC id"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "The list of private db subnets"
  value       = tolist(aws_subnet.private_dbs.*.id)
}

output "postgres_sg" {
  description = "The security group with only access to postgresql"
  value       = aws_security_group.postgres_sg.id
}

output "cidr_block" {
  description = "The VPC cidr block"
  value = aws_vpc.this.cidr_block
}

output "db_subnet_group_name" {
  description = "The name of db subnet group"
  value = aws_db_subnet_group.this.name
}
