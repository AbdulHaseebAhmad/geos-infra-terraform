module "geos" {
  source = "../../modules/geos-infra"

  aws_region               = var.aws_region
  vpc_cidr                 = var.vpc_cidr
  environment_name         = var.environment_name
  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}