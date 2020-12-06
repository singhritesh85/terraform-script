variable "region" {
description = "The region into which to create the RDS"
type = string
default = "us-east-2"
}
variable "identifier" {
description = "Provide the DB Instance Name"
type = string
}
variable "read_replica_identifier" {
description = "Provide the Read-Replica DB Instance Name"
type = string
default = "read-replica-06122020"   ####Provide the Read Replica Name in Lower Case
}
variable "allocated_storage" {
description ="Memory Allocated for RDS"
type = number
default = 20
}
variable "max_allocated_storage" {
description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
type = number
default = 100
}
variable "read_replica_max_allocated_storage" {
description = "The upper limit to which Amazon RDS Read Replica can automatically scale the storage of the DB instance"
type = number
default = 1000
}
variable "storage_type" {
description = "storage type of RDS"
type = string
default = "gp2"
}
variable "read_replica_storage_type" {
description = "storage type of RDS Read Replica"
type = string
default = "gp2"
}
variable "engine" {
description = "Engine of RDS"
type = list
default = ["mysql", "mariadb", "mssql", "postgresql"]
}
variable "engine_version" {
description = "Engine Version of RDS"
type = list
default = ["5.7.25", "5.7.28", "8.0.15", "8.0.20"]
}
variable "instance_class" {
description = "DB Instance Type"
type = list
default = ["db.t2.micro", "db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
}
variable "read_replica_instance_class" {
description = "DB Instance Type of Read Replica"
type = list
default = ["db.t2.micro", "db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
}
variable "rds_db_name" {
description = "Provide the DB Name"
type = string
}
variable "username" {
description = "Provide the DB Instance username"
type = string
}
variable "password" {
description = "Provide the Password of DB Instance"
type = string
}
variable "parameter_group_name" {
description = "Parameter Group Name for RDS"
type = string
default = "default.mysql5.7"
}
variable "multi_az" {
description = "To enable or disable multi AZ"
type = list
default = [true, false]
}
variable "read_replica_multi_az" {
description = "To enable or disable multi AZ"
type = list
default = [true, false]
}
variable "final_snapshot_identifier" {
description = "Provide the Final Snapshot Name"
type = string
default = "final-snapshot-before-deletion"
}
variable "skip_final_snapshot" {
description = "To skip Final Snapshot before deletion"
type = list
default = [true, false]
}
variable "copy_tags_to_snapshot" {
description = "Copy Tags to Final Snapshot"
type = list
default = [true, false]
}
variable "availability_zone" {
description = "Availabilty Zone of the RDS DB Instance"
type = list
default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
variable "publicly_accessible" {
description = "To make RDS publicly Accessible or not"
type = list
default = [true, false]
}
variable "vpc_security_group_ids" {
description = "List of VPC security groups to associate"
type = list
default = ["sg-04be052143c79bd66", "sg-0fa141a9899965afb"]  ##You should change this value as per your vpc security group
}
variable "read_replica_vpc_security_group_ids" {
description = "List of VPC security groups to br associated with RDS Read Replica"
type = list
default = ["sg-02d48ca1ba3da3118"]  ##You should change this value as per your vpc security group
}
variable "backup_retention_period" {
description = "The days to retain backups for. Must be between 0 and 35"
type = list
default = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]
}
variable "kms_key_id" {
description = "ARN of Kms Key Id to encrypt the RDS Volume"
type = string
default = "arn:aws:kms:us-east-2:562086155953:key/f84495e4-58be-44b8-b719-0d491fa5311f"
}
variable "read_replica_kms_key_id" {
description = "ARN of Kms Key Id to encrypt the RDS Volume of Read Replica"
type = string
default = "arn:aws:kms:us-east-1:562086155953:key/7ccdc14f-4f59-450d-855c-2d66a837e528"
}
variable "monitoring_role_arn" {
description = "ARN of IAM Role to enable enhanced monitoring"
type = string
default = "arn:aws:iam::562086155953:role/rds-monitoring-role"
}
