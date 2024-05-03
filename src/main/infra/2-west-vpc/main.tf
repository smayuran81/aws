variable "region_ireland" {
  type = string
  default = "eu-west-1"
}

variable "region_london" {
  type = string
  default = "eu-west-2"
}

variable "vpc_cidr_range_ireland" {

  type = string
  default = "10.10.0.0/16"
}


variable "public_subnets_ireland" {
  type = list(string)
  default = ["10.10.0.0/24","10.10.1.0/24"]
}

variable "database_subnets_ireland" {
  type = list(string)
  default = ["10.11.8.0/24", "10.11.9.0/24"]
}


variable "vpc_cidr_range_london" {

  type = string
  default = "10.11.0.0/16"
}

variable "public_subnets_london" {
  type = list(string)
  default = ["10.11.0.0/24","10.11.1.0/24"]
}

variable "database_subnets_london" {
  type = list(string)
  default = ["10.11.8.0/24", "10.11.9.0/24"]
}


#####################
# PROVIDERS
######################
provider "aws" {
  region = var.region_ireland
  alias = "prod_ireland"

}


provider "aws" {
  region = var.region_london
  alias = "prod_london"

}

#####################
# DATA SOURCES
######################

/*
data "aws_availability_zone" "azs_ireland" {

  provider = aws.ireland
}


data "aws_availability_zone" "azs_london" {

  provider = aws.london
}
*/

/*
resource "aws_iam_role" "sec_role" {
  provider = aws.security
  assume_role_policy = ""
}
*/

#####################
# DATA SOURCES
######################

module "vpc_ireland" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.prod_ireland
  }
  name = "prod-vpc-ireland"
  cidr = var.vpc_cidr_range_ireland
  azs            = ["eu-west-1a", "eu-west-1b"]
  public_subnets = var.public_subnets_ireland

}

module "vpc_london" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws = aws.prod_london
  }
  name = "prod-vpc-london"
  cidr = var.vpc_cidr_range_london
  azs            = ["eu-west-2a", "eu-west-2b"]
  public_subnets = var.public_subnets_london

}

output "vpc_ireland" {
  value = module.vpc_ireland.vpc_id
}

output "vpc_london" {
  value = module.vpc_london
}


