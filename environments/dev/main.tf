module "geos" {
  source = "../../modules/geos-infra"

  aws_region               = var.aws_region
  vpc_cidr                 = var.vpc_cidr
  environment_name         = var.environment_name
  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  geos_app_servers         = var.geos_app_servers
  geos_bastion_server      = var.geos_bastion_server
  geos_domain_name         = var.geos_domain_name
  geos_hosted_zone_name    = var.geos_hosted_zone_name
}