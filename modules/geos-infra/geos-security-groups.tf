#ALB Security Group

resource "aws_security_group" "geos_alb_sg" {
  name        = "geos_alb_sg"
  description = "Allow http and https inbound traffic from the internet"
  vpc_id      = aws_vpc.geos_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-alb-sg"
  }

}


# Bastion Security Group

resource "aws_security_group" "geos_bastion_sg" {
  name        = "geos_bastion_sg"
  description = "Allow SSH inbound traffic from the internet for bastion"
  vpc_id      = aws_vpc.geos_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-bastion-sg"
  }
}

# App Server Security Group 

resource "aws_security_group" "geos_app_sg" {
  name        = "geos_app_sg"
  description = "Allow SSH inbound traffic from the bastion and inbound traffic from ALB"
  vpc_id      = aws_vpc.geos_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.geos_alb_sg.id]
    protocol        = "tcp"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.geos_bastion_sg.id]
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-app-server-sg"
  }
}


resource "aws_security_group" "geos_db_sg" {
  name        = "geos_db_sg"
  description = "Allow inbound traffic from the appp servers to the db servers"
  vpc_id      = aws_vpc.geos_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    security_groups = [aws_security_group.geos_app_sg.id]
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-db-server-sg"
  }
}