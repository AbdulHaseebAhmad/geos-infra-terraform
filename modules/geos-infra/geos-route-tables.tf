resource "aws_route_table" "geos_public_route_table" {
  vpc_id = aws_vpc.geos_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.geos_igw.id
  }

  tags = {
    Environment = "${var.environment_name}"
    Name        = "${var.environment_name}-geos-public-route-table"
    Tier        = "public"
  }
}

resource "aws_route_table_association" "geos_public_route_table_association" {
  count          = length(aws_subnet.geos_public)
  subnet_id      = aws_subnet.geos_public[count.index].id
  route_table_id = aws_route_table.geos_public_route_table.id
}

resource "aws_route_table" "geos_private_app_route_table" {
  vpc_id = aws_vpc.geos_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.geos_ngw.id
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-private-app-route-table"
    Tier        = "private"
  }
}

resource "aws_route_table_association" "geos_private_app_route_table_association" {
  count          = length(aws_subnet.geos_private_app)
  subnet_id      = aws_subnet.geos_private_app[count.index].id
  route_table_id = aws_route_table.geos_private_app_route_table.id
}


resource "aws_route_table" "geos_private_db_route_table" {
  vpc_id = aws_vpc.geos_vpc.id

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-private-db-route-table"
    Tier        = "private"
  }
}

resource "aws_route_table_association" "geos_private_db_route_table_association" {
  count          = length(aws_subnet.geos_private_db)
  subnet_id      = aws_subnet.geos_private_db[count.index].id
  route_table_id = aws_route_table.geos_private_db_route_table.id
}

