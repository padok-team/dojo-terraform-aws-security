variable "aws_region" {
  type    = string
  default = "eu-west-3"
  description = "the region were the assets will be deployed"
}

variable "aws_profile" {
  type    = string
  description = "Name of the AWS profile in ~/.aws/credentials"
  default = "padok_supelec"
}

variable "environment" {
  type    = string
  description = "Name of the environment"
}

variable "vpc_id" {
  type    = string
  description = "ID of the VPC"
}

variable "public_subnet_id" {
  type    = string
  description = "ID of the public subnet"
}
