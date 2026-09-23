resource "aws_db_instance" "geos_rds_instance" {
  allocated_storage           = 50
  db_name                     = "postgress"
  engine                      = "postgres"
  engine_version              = "17"
  instance_class              = "db.t3.micro"
  parameter_group_name        = "default.postgres17"
  skip_final_snapshot         = true
  manage_master_user_password = true
  username                    = "geosadmin"
  vpc_security_group_ids      = [aws_security_group.geos_db_sg.id]
  db_subnet_group_name        = aws_db_subnet_group.geos_rds_db_subnet_group.name

  tags = {
    Name        = "geos-rds-db-instance"
    Environment = "${var.environment_name}-geos-rds-instance"
  }
}
