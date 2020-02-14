variable "aws_profile" {
  description = "AWS Profile to be used"
}
variable "aws_region" {
  description = "AWS Region to be used"
}
variable "backend_subpath" {
  description = "Terraform backend sub-path"
}
variable "account_alias" {
  description = "AWS account alias for this project"
}

# DNS
variable "public_domain_name" {
  description = "The domain name"
}
variable "private_domain_name" {
  description = "The sub domain name to be used internally on vpc"
}

# VPC01
variable "vpc01_cidr" {}
variable "vpc01_azs" {}
variable "vpc01_public_subnets" {}

# Whitelist IP Addresses
variable "whitelist_ips" {
  description = "List IP Address to be whitelisted"
}

# EKS Cluster
variable "eks" {
  description = "EKS Cluster Configurations"
}

# Declare Tags
locals {
  tags = {
    Project     = "This Project name"
    Environment = "Lab"
    Terraform   = "True"
    Info        = "This is managed by Terraform. Do not make any manual changes."
  }
}