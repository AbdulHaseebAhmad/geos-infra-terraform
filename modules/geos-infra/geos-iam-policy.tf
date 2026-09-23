resource "aws_iam_policy" "geos_ec2_iam_policy" {
name = "${var.environment_name}-geos_ec2_policy"
  path        = "/"
  description = "Allows the EC2 instance to retrieve the RDS credentials from Secrets Manager"


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
        ]
        Effect   = "Allow"
        Resource = aws_db_instance.geos_rds_instance.master_user_secret[0].secret_arn
      },
    ]
  })

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-iam-policy"
  }
}

resource "aws_iam_role_policy_attachment" "geos_ec2_policy_attachment" {
  role       = aws_iam_role.geos_ec2_iam_role.name
  policy_arn = aws_iam_policy.geos_ec2_iam_policy.arn
}

resource "aws_iam_instance_profile" "geos_ec2_instance_profile" {
  name = "${var.environment_name}-geos-ec2-instance-profile"
  role = aws_iam_role.geos_ec2_iam_role.name

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-ec2-instance-profile"
  }
}