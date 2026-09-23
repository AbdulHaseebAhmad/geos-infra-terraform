variable "environment_name" {
  description = "The environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the GEOS VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the development environment"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for development public subnets"
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for development application subnets"
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for development database subnets"
  type        = list(string)
}

variable "geos_app_servers" {
  type = object({
    ami           = string
    instance_type = string
    key_name      = string
  })

}

variable "geos_bastion_server" {
  type = object({
    ami           = string
    instance_type = string
    key_name      = string
  })

}

variable "geos_domain_name" {
  type        = string
  description = "The Domain Name"
}

variable "geos_hosted_zone_name" {
  type        = string
  description = "The Hosted Zone name for the domain"
}

