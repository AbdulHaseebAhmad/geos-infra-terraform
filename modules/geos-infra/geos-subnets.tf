resource "aws_subnet" "geos_public" {
  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.geos_vpc.id

  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-geos-public-${count.index + 1}"
    Environment = var.environment_name
    Tier        = "public"
  }
}

resource "aws_subnet" "geos_private_app" {
  count = length(var.private_app_subnet_cidrs)

  vpc_id = aws_vpc.geos_vpc.id

  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-geos-private-app-${count.index + 1}"
    Environment = var.environment_name
    Tier        = "private-app"
  }
}

resource "aws_subnet" "geos_private_db" {
  count = length(var.private_db_subnet_cidrs)

  vpc_id = aws_vpc.geos_vpc.id

  cidr_block        = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-geos-private-db-${count.index + 1}"
    Environment = var.environment_name
    Tier        = "private-db"
  }
}