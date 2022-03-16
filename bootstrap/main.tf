# version
terraform {
  required_version = ">= 1.0"
}

# providers
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.38.0"
    }
  }
}

/* 
Create a user for eleves with access key and appropriate IAM policy
*/
resource "aws_iam_user" "eleve" {
  name = "eleve"
}

resource "aws_iam_access_key" "eleve" {
  user = aws_iam_user.eleve.name
}

resource "aws_iam_user_policy" "eleve" {
  name = "eleve_policy"
  user = aws_iam_user.eleve.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "elasticloadbalancing:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

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
