variable "environment" {
  description = "Application environment"
}

variable "region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "vpc_id" {
  description = "VPC ID to use"
}

variable "subnet_ids" {
  description = "Comma separated subnet ids to be used"
}

variable "engine" {
  description = "DB hosted as a service in AWS RDS"
  default     = "postgres"
}

variable "engine_version" {
  description = "DB version; by default we assume it is Postgres that is used"
  default     = "9.6.6"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "db_name" {
  description = "Note: must begin with a letter and contain only alphanumeric characters"
}

variable "username" {}
variable "password" {}
variable "apply_immediately" {}

variable "size" {
  default = "100"
}

variable "maintenance_window" {
  description = "Best time window to perform maintenance tasks"
  default     = "Mon:03:00-Mon:06:00"
}

variable "backup_window" {
  default = "00:00-02:55"
}

variable "backup_retention_period" {
  default = 7
}

variable "skip_final_snapshot" {
  default = false
}

variable "db_sg_egress_cidr" {
  default = "0.0.0.0/0"
}

variable "income_cidr_blocks" {
  description = "RDS default CIDR block to allow connections from"
  type        = "list"
  default     = ["0.0.0.0/0"]
}
