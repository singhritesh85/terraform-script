output "rds_db_instance_id" {
  description = "The RDS DB Instance id"
  value       = aws_db_instance.dbinstance.id
}
output "rds_read_replica_instance_id" {
  description = "The Read Replica DB Instance id"
  value       = aws_db_instance.read_replica.id
}
