// Identifier of the mssql DB instance.
output "mssql_id" {
  value = "${aws_db_instance.default_mssql.id}"
}

// Address of the mssql DB instance.
output "mssql_address" {
  value = "${aws_db_instance.default_mssql.address}"
}