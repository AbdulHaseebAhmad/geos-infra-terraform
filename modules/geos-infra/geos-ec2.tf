resource "aws_instance" "geos_app_servers" {
  count                  = length(aws_subnet.geos_private_app)
  ami                    = var.geos_app_servers.ami
  instance_type          = var.geos_app_servers.instance_type
  key_name               = var.geos_app_servers.key_name
  subnet_id              = aws_subnet.geos_private_app[count.index].id
  vpc_security_group_ids = [aws_security_group.geos_app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.geos_ec2_instance_profile.name
  user_data = templatefile(
    "${path.module}/templates/user-data.sh.tpl",
    {
      rds_secret_arn = aws_db_instance.geos_rds_instance.master_user_secret[0].secret_arn
      rds_endpoint   = aws_db_instance.geos_rds_instance.address
    }
  )

  tags = {
    Name        = "${var.environment_name}-geos-app-server-${count.index + 1}"
    Environment = var.environment_name
  }
}

resource "aws_instance" "geos_bastion_server" {
  ami                         = var.geos_bastion_server.ami
  instance_type               = var.geos_bastion_server.instance_type
  key_name                    = var.geos_bastion_server.key_name
  subnet_id                   = aws_subnet.geos_public[0].id
  vpc_security_group_ids      = [aws_security_group.geos_bastion_sg.id]
  associate_public_ip_address = true
  tags = {
    Name        = "${var.environment_name}-geos-bastion-server"
    Environment = var.environment_name
  }
}