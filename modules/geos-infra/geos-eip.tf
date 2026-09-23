resource "aws_eip" "geos_nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "${var.environment_name}-geos-nat-eip"
    Environment = var.environment_name
  }
}