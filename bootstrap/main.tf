terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11"
    }
  }
}
provider "aws" {
  profile = "padok-lab"
  region  = "eu-west-3"
}

/* 
Grant IAM Role to the user's EC2
*/

## TODO

data "aws_availability_zones" "available" {}

/* 
VPC is Virtual Private Cloud. 
This module will create a VPC with private and public subnets 
*/
module "vpc" {
  for_each = toset(["prd", "dev"])
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.7.0"

  // Name of the VPC
  name            = "${each.key}-vpc"

  // CIDR
  cidr            = "10.0.0.0/16"

  // Avaibility zone for geographic location
  azs             = data.aws_availability_zones.available.names

  // CIDR of the private and public subnets
  private_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  public_subnets  = ["10.0.0.0/24","10.0.3.0/24"]


  // NAT gateway to enable egress traffic 
  enable_nat_gateway           = true
  single_nat_gateway           = true
}
