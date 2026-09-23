# GEOS Infrastructure — Terraform

Terraform-based Infrastructure as Code for **GEOS**, a four-portal SaaS EdTech platform (SysAdmin, School, Student, University), rebuilding the infrastructure previously provisioned through Bash and AWS CLI.

## Why this exists

GEOS infrastructure was initially provisioned using **Bash scripts and AWS CLI** to understand and automate the underlying AWS resources.

This repository rebuilds that infrastructure using **Terraform**, with a focus on reusable infrastructure, environment separation, and repeatable deployments.

The goal is not simply to recreate the infrastructure, but to move from infrastructure-as-scripts to a more maintainable **declarative Infrastructure as Code** approach.

## Architecture

* 3-tier AWS VPC architecture
* Public subnet for the Application Load Balancer
* Private subnet for application/EC2 instances
* Private subnet for PostgreSQL/RDS
* Single reusable Terraform module for the core infrastructure
* Separate `dev` and `prod` environments
* Separate Terraform state configuration for each environment
* EC2 provisioning through a reusable `user-data.sh.tpl` template
* Infrastructure configuration managed through Terraform variables

```text
Internet
   │
   ▼
┌─────────────────────┐
│         ALB         │
│    Public Subnet    │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│       EC2/App       │
│   Private Subnet    │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│        RDS          │
│   Private Subnet    │
└─────────────────────┘
```

## Terraform Structure

```text
geos-infra-terraform/
│
├── modules/
│   └── geos-infra/
│       ├── providers.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── vpc.tf
│       ├── alb.tf
│       ├── rds.tf
│       ├── iam.tf
│       ├── ec2.tf
│       └── templates/
│           └── user-data.sh.tpl
│
└── environments/
    ├── dev/
    │   ├── main.tf
    │   ├── backend.tf
    │   └── terraform.tfvars
    │
    └── prod/
        ├── main.tf
        ├── backend.tf
        └── terraform.tfvars
```

### Module

`modules/geos-infra` contains the reusable infrastructure definition.

The module is responsible for provisioning the core AWS resources while remaining independent of a specific environment.

### Environments

Each environment has its own root Terraform configuration.

```text
environments/dev
environments/prod
```

This allows development and production to use the same infrastructure module while passing different configuration values.

Each environment also maintains its own Terraform backend/state configuration.

## Deployment

Terraform is initialised from the environment being deployed.

### Development

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Production

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## Infrastructure Components

The Terraform module currently covers:

* **VPC** — networking and subnet architecture
* **ALB** — application load balancing
* **EC2** — application compute
* **RDS** — PostgreSQL database infrastructure
* **IAM** — AWS permissions and roles
* **User Data** — EC2 instance bootstrapping
* **Terraform State** — environment-specific state management

## From Bash to Terraform

This repository is also part of the evolution of the GEOS infrastructure.

```text
AWS Console
     ↓
Bash + AWS CLI
     ↓
Terraform
```

The original infrastructure was provisioned through scripts that explicitly instructed AWS how to create each resource.

The Terraform implementation moves the project toward a **declarative model**, where the desired infrastructure is defined as code and Terraform manages the changes required to reach that state.

## Status

[svg](https://github.com/AbdulHaseebAhmad/geos-infra-terraform#status)

Completed

The GEOS infrastructure has been successfully rebuilt from Bash-based AWS provisioning scripts to Terraform.

The project now includes:

- Reusable Terraform module with separate dev and production environments
- 3-tier VPC architecture across 2 Availability Zones
- Public, private application and private database subnets
- Application Load Balancer with HTTP to HTTPS redirection
- EC2 application servers and bastion host
- RDS PostgreSQL in private subnets
- IAM roles and policies for application access to AWS services
- Secrets Manager integration for runtime database credentials
- ACM certificates with DNS validation through Route 53
- S3 remote state with DynamoDB state locking
- Existing CI/CD pipeline integrated with the Terraform-managed infrastructure

The infrastructure has been deployed and tested on AWS as part of the GEOS production platform.
