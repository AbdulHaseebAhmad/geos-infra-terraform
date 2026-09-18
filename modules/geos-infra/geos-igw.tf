resource "aws_internet_gateway" "geos_igw" {
  vpc_id = aws_vpc.geos_vpc.id

  depends_on = [
    aws_vpc.geos_vpc
  ]


  tags = {
    Name        = "${var.environment_name}-geos-igw"
    Environment = var.environment_name
  }
}