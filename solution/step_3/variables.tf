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

variable "ip_whitelist" {
  type = list
  description = "List of IP adresse authorized to access Load Balancer"
  default = []
}
