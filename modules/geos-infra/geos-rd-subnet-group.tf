resource "aws_db_subnet_group" "geos_rds_db_subnet_group" {
name = "${var.environment_name}-geos-rds-db-subnet-group"
  subnet_ids = [aws_subnet.geos_private_db[0].id, aws_subnet.geos_private_db[1].id]

  tags = {
    Name        = "${var.environment_name}-geos-rds-db-subnet-group"
    Environment = var.environment_name
  }
}
