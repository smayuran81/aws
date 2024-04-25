variable "region_1" {
  type = string
  default = "eu-east-1"
}

variable "region_2" {
  type = string
  default = "eu-west-1"
}

variable "vpc_cidr_range_east" {

  type = string
  default = "10.10.0.0/16"
}

variable "vpc_cidr_range_west" {

  type = string
  default = "10.10.0.0/16"
}

variable "public_subnets_east" {
  type = list(string)
  default = ["10.10.0.0/24","10.10.1.0/24"]
}