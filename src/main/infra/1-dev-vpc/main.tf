variable "region" {
  type    = string
  default = "eu-west-1"

}

variable "vpc_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  description = "Public Subnet CIDR values"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "database_subnets" {

  type    = list(string)
  description = "Database Subnet CIDR values"
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

#variable "webserver_subnets" {}


###############################
# PROVIDERS
###############################
provider "aws" {

  region = var.region
  alias = "aws"
  #alias = "security"
}


###############################
# DATA SOURCES
###############################

#data "aws_availability_zone" "azs" {

  #filter {
   # name   = "region-name"
    #values = ["eu-west-1"]
  #}

#}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "dev-vpc"
  cidr   = var.vpc_cidr_range

  azs            = ["eu-west-2a", "eu-west-2b"]
  public_subnets = var.public_subnets


  #Database subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets = var.database_subnets
 database_subnet_group_tags = {
  subnet_type = "database"
  }

  tags = {
    Environment = "dev"
    Team        = "infra"
  }
}

############
#OUTPUTS
############

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "db_subnet_group" {
  value = module.vpc.database_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}