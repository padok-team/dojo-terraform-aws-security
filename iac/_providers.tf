provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "random" {
}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    aws = {
      version = "3.38.0"
    }
  }
}
