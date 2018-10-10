output "aws_security_group_id" {
  value = "${aws_security_group.this.id}"
}

output "aws_security_group_name" {
  value = "${aws_security_group.this.name}"
}

output "aws_db_instance_id" {
  value = "${aws_db_instance.this.id}"
}

output "aws_db_instance_address" {
  value = "${aws_db_instance.this.address}"
}

output "aws_db_instance_endpoint" {
  value = "${aws_db_instance.this.endpoint}"
}

output "aws_db_subnet_group_id" {
  value = "${aws_db_subnet_group.this.id}"
}

output "aws_db_subnet_group_name" {
  value = "${aws_db_subnet_group.this.name}"
}

output "aws_db_subnet_group_arn" {
  value = "${aws_db_subnet_group.this.arn}"
}

output "aws_db_parameter_group_id" {
  value = "${aws_db_parameter_group.this.id}"
}

output "aws_db_parameter_group_name" {
  value = "${aws_db_parameter_group.this.name}"
}

output "aws_db_parameter_group_arn" {
  value = "${aws_db_parameter_group.this.arn}"
}
