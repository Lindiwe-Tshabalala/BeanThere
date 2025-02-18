output "db_endpoint" {
  description = "The endpoint of the RDS database instance"
  value       = aws_db_instance.bean_there_db.endpoint
}

output "db_instance_id" {
  description = "The identifier of the RDS database instance"
  value       = aws_db_instance.bean_there_db.id
}
