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
  alias = "ireland"
}


provider "aws" {
  region = var.region_london
  alias = "london"
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

#####################
# DATA SOURCES
######################

module "vpc_east" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod-vpc-east"
  cidr = var.vpc_cidr_range_ireland
  azs            = ["eu-west-2a", "eu-west-2b"]
  public_subnets = var.public_subnets_ireland

}


