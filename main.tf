resource "aws_security_group" "this" {
  description = "Controls access to RDS instance ${var.db_name} in ${var.environment}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.environment}-${var.engine}-${var.db_name}-sg"
    Environment = "${var.environment}"
    Application = "${var.db_name}-${var.engine}"
  }
}

# Allow egress traffic
resource "aws_security_group_rule" "this" {
  security_group_id = "${aws_security_group.this.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.db_sg_egress_cidr}"]
  type              = "egress"
}

# Allow ingress traffic
resource "aws_security_group_rule" "ingress" {
  security_group_id = "${aws_security_group.this.id}"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${var.income_cidr_blocks}"]
  type              = "ingress"
}

resource "aws_db_instance" "this" {
  identifier                = "${var.environment}-${var.db_name}-${var.engine}"
  allocated_storage         = "${var.size}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  instance_class            = "${var.instance_class}"
  name                      = "${var.db_name}"
  username                  = "${var.username}"
  password                  = "${var.password}"
  db_subnet_group_name      = "${aws_db_subnet_group.this.name}"
  vpc_security_group_ids    = ["${aws_security_group.this.id}"]
  apply_immediately         = "${var.apply_immediately}"
  maintenance_window        = "${var.maintenance_window}"
  backup_window             = "${var.backup_window}"
  backup_retention_period   = "${var.backup_retention_period}"
  copy_tags_to_snapshot     = true
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "final-${var.environment}-${var.db_name}-ss-before-deletion"
  parameter_group_name      = "${aws_db_parameter_group.this.id}"

  tags {
    Name        = "${var.environment}-${var.db_name}"
    Environment = "${var.environment}"
    Application = "${var.db_name}-${var.engine}"
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.environment}-${var.db_name}-db-subnet-group"
  description = "${var.engine} Subnet Group for ${var.db_name} System"
  subnet_ids  = ["${split(",", var.subnet_ids)}"]

  tags {
    Name        = "${var.environment}-${var.db_name}-subnet-group-${var.engine}"
    Environment = "${var.environment}"
    Application = "${var.db_name}-db-subnet-group"
  }
}

#
# Parameter group for daily/normal operations
#
resource "aws_db_parameter_group" "this" {
  name = "${var.engine}-cluster-${var.db_name}"

  # example fmaily: family = postgres9.6
  family      = "${var.engine}${element(split(".",var.engine_version), 0)}.${element(split(".",var.engine_version), 1)}"
  description = "${var.db_name} ${var.engine} - parameter group"
}
