terraform {
  backend "s3" {
    key = "networking/dev-vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}