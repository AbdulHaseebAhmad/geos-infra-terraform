resource "aws_nat_gateway" "geos_ngw" {
  allocation_id = aws_eip.geos_nat_eip.id
  subnet_id     = aws_subnet.geos_public[0].id

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-ngw"
    Tier        = "public"
  }


  depends_on = [aws_internet_gateway.geos_igw]
}
