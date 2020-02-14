# PROVIDER
aws_profile = "default" // Modify this by following your .aws/credential configuration

# BACKEND
backend_subpath = ".terraform.tfstate/"

# IAM ACCOUNT
account_alias = "nil"

# AWS Region
aws_region = "us-west-2"

# Domain Name
public_domain_name  = "example.com"
private_domain_name = "int.example.com"

# VPC 
vpc01_cidr           = "10.0.0.0/16"
vpc01_azs            = ["us-west-2a", "us-west-2b", "us-west-2c"]
vpc01_public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

# Whitelist IPs
whitelist_ips = ["0.0.0.0/24",]

# EKS Cluster Configurations
eks = {
  # cluster_name = "nil" // Cluster Name
  # admin_rolearn = "arn:aws:iam::<NUM>:role/AWSReservedSSO_<ROLE>_<NUM>"
  # instance_type = "m5.large" // Worker Instance type
  # worker_count = 2 // Worker Node count
  # root_volume_size = 100 // Worker root volume size
}
