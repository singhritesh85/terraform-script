resource "aws_db_parameter_group" "dbparametedgroup" {
  name   = "rds-pg"
  family = "mysql5.7"
  description = "Parameter Group For RDS"

#It is also possible that we cann't provide the parametes
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
resource "aws_db_subnet_group" "dbsubnet" {
  name       = "subnet-group12052020"
  description = "RDS DB Subnet Group"
  subnet_ids = ["subnet-5d85d427", "subnet-e116afad", "subnet-ea2f3482"]  ##You should change this value as per your vpc subnet
}
resource "aws_db_subnet_group" "read_replica_dbsubnet" {
  provider = aws.us-east-1
  name       = "subnet-group12062020"
  description = "RDS DB Subnet Group"
  subnet_ids = ["subnet-108dcf2e", "subnet-29eb2564", "subnet-35f0003b", "subnet-872e2ba9", "subnet-d58eb1b2", "subnet-e1142fbd"]  ##You should change this value as per your vpc subnet
}
resource "aws_db_instance" "dbinstance" {
  identifier           = var.identifier
  allocated_storage    = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine[0]
  engine_version       = var.engine_version[0]
  instance_class       = var.instance_class[1]
  name                 = var.rds_db_name
  username             = var.username
  password             = var.password
#  parameter_group_name = var.parameter_group_name
  multi_az             = var.multi_az[0]
#  final_snapshot_identifier = var.final_snapshot_identifier ##To enable it skip_final_snapshot should be disabled
  skip_final_snapshot  = var.skip_final_snapshot[0]   ##when skip_final_snapshot is true then final_snapshot_identifier should be commented
#  copy_tags_to_snapshot = var.copy_tags_to_snapshot[0]   ##You can enable it when final_snapshot_identifier is enable i.e. when final snapshot is enabled
#  availability_zone = var.availability_zone[0]  ## NOT ENABLE FOR MULTI-AZ OPTION
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.name
  parameter_group_name = aws_db_parameter_group.dbparametedgroup.name
  publicly_accessible = var.publicly_accessible[1]
  backup_retention_period = var.backup_retention_period[7]   ##Choose the number of days that RDS should retain automatic backups for this instance.
  backup_window = "09:46-10:16"            ##(The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". Must not overlap with maintenance window)
  delete_automated_backups = true   ##(Specifies whether to remove automated backups immediately after the DB instance is deleted, default is true)
  maintenance_window = "Mon:00:00-Mon:03:00" ##The window to perform maintenance in Syntax: "ddd:hh24:mi-ddd:hh24:mi" Eg: "Mon:00:00-Mon:03:00"
  deletion_protection = false ##SHOULD BE ENABLED FOR PRODUCTION ENVIRONMENT
  storage_encrypted = true
  kms_key_id = var.kms_key_id    ##The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN.
  apply_immediately = true  ##Specifies whether any database modifications are applied immediately, or during the next maintenance window, default is false
#  replicate_source_db  ##This correlates to the identifier of another Amazon RDS Database to replicate (if replicating within a single region) or ARN of the Amazon RDS Database to replicate (if replicating cross-region). Removing the replicate_source_db attribute from an existing RDS Replicate database managed by Terraform will promote the database to a fully standalone database.
  auto_minor_version_upgrade = true ## true or false
  monitoring_role_arn = var.monitoring_role_arn ##arn:aws:iam::562086155953:role/rds-monitoring-role
  monitoring_interval = 5 ##The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  tags = {         ##use tags as required
    Environment = "Dev"
    Date = "06-12-2020"
  }
}


resource "aws_db_instance" "read_replica" {
  provider = aws.us-east-1
  identifier           = var.read_replica_identifier
  max_allocated_storage = var.read_replica_max_allocated_storage
  storage_type         = var.read_replica_storage_type
  instance_class       = var.read_replica_instance_class[1]
#  parameter_group_name = var.parameter_group_name
  multi_az             = var.read_replica_multi_az[0]
#  final_snapshot_identifier = var.final_snapshot_identifier ##To enable it skip_final_snapshot should be disabled
  skip_final_snapshot  = var.skip_final_snapshot[0]   ##when skip_final_snapshot is true then final_snapshot_identifier should be commented
#  copy_tags_to_snapshot = var.copy_tags_to_snapshot[0]   ##You can enable it when final_snapshot_identifier is enable i.e. when final snapshot is enabled
#  availability_zone = var.availability_zone[0]  ## NOT ENABLE FOR MULTI-AZ OPTION
  vpc_security_group_ids = var.read_replica_vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.read_replica_dbsubnet.name
  publicly_accessible = var.publicly_accessible[0]
  backup_retention_period = var.backup_retention_period[7]   ##Choose the number of days that RDS should retain automatic backups for this instance.
  backup_window = "10:30-11:00"            ##(The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". Must not overlap with maintenance window)
  delete_automated_backups = true   ##(Specifies whether to remove automated backups immediately after the DB instance is deleted, default is true)
  maintenance_window = "Mon:00:00-Mon:03:00" ##The window to perform maintenance in. Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00"
  deletion_protection = false ##SHOULD BE ENABLED FOR PRODUCTION ENVIRONMENT
  storage_encrypted = true
  kms_key_id = var.read_replica_kms_key_id    ##The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN.
  apply_immediately = true  ##Specifies whether any database modifications are applied immediately, or during the next maintenance window, default is false
  replicate_source_db = aws_db_instance.dbinstance.arn  ##This correlates to the identifier of another Amazon RDS Database to replicate (if replicating within a single region) or ARN of the Amazon RDS Database to replicate (if replicating cross-region). Removing the replicate_source_db attribute from an existing RDS Replicate database managed by Terraform will promote the database to a fully standalone database.
  auto_minor_version_upgrade = true ## true or false
  monitoring_role_arn = var.monitoring_role_arn ##arn:aws:iam::562086155953:role/rds-monitoring-role
  monitoring_interval = 10 ##The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  tags = {         ##use tags as required
    Environmen = "Dev"
    Date = "06-12-2020"
    Type = "Read-Replica"
  }
  depends_on = [aws_db_instance.dbinstance]
}
