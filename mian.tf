resource "aws_db_subnet_group" "default_rds_mssql" {
  name        = "${var.environment}-rds-mssql-subnet-group"
  description = "The ${var.environment} rds-mssql private subnet group."
  subnet_ids  = ["${var.vpc_subnet_ids}"]

  tags {
    Name = "${var.environment}-rds-mssql-subnet-group"
    Env  = "${var.environment}"
  }
}

resource "aws_security_group" "rds_mssql_security_group" {
  name        = "${var.environment}-rds-mssql"
  description = "${var.environment} allow all vpc traffic to rds mssql."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_blocks}"]
  }

  tags {
    Name = "${var.environment}-rds-mssql"
    Env  = "${var.environment}"
  }
}


resource "aws_db_instance" "default_mssql" {
  depends_on                = ["aws_db_subnet_group.default_rds_mssql"]
  identifier                = "${var.environment}-mssql"
  allocated_storage         = "${var.rds_allocated_storage}"
  license_model             = "license-included"
  storage_type              = "gp2"
  engine                    = "sqlserver-se"
  engine_version            = "15.00.4198.2.v1"
  instance_class            = "${var.rds_instance_class}"
  availability_zone         = "${var.availability_zone}"
  username                  = "${var.mssql_admin_username}" // replace this with data block if you have secret manager
  password                  = "${var.mssql_admin_password}" // same as above, variables not added for these two
  vpc_security_group_ids    = "${aws_security_group.rds_mssql_security_group.id}"
  db_subnet_group_name      = "${aws_db_subnet_group.default_rds_mssql.id}"
  backup_retention_period   = 3
  skip_final_snapshot       = true
  
}

// add storage encrption if you have kms already

// kms_key_id = var.kms_key_arn
// storage_encrpted = true


//for secrets manager 

//data "aws_secretsmanager_secret_version" "db" {
    # mention the name for your secret
  //  secret_id = var.secret_id
//}

//username = jsoncode(data.aws_secretsmanager_secret_version.db.secret_string)["username"]