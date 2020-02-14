provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  version = "~> 2.45"
}

terraform {
  required_version = ">= 0.12.0"
  backend "local" {
    path = ".terraform.state/terraform.tfstate"
  }
}

# NOTE: All version control will be inside here