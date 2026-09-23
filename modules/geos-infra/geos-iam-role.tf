resource "aws_iam_role" "geos_ec2_iam_role" {
  name = "geos_ec2_iam_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Environment = var.environment_name
    Name        = "${var.environment_name}-geos-ec2-role"
  }
}
