data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc01.vpc_id
}

module "vpc01" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.24.0"

  name           = "vpc01"
  cidr           = "${var.vpc01_cidr}"
  azs            = "${var.vpc01_azs}"
  public_subnets = "${var.vpc01_public_subnets}"
  #private_subnets        = "${var.vpc01_private_subnets}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  #enable_nat_gateway     = true // This cannot be enabled if we dont have any private subnet associations
  #one_nat_gateway_per_az = true // This cannot be enabled if we dont have any private subnet associations

  # Route Table Propagation 
  propagate_public_route_tables_vgw = true
  # propagate_private_route_tables_vgw = true // This cannot be enabled if we dont have any private subnet associations

  # VPN Config
  enable_vpn_gateway = true
  //amazon_side_asn    = "" Enable this is if going to custom amazon side asn if not then by default Amazon side asn is "64512"
  /*
  customer_gateways = {
    IP1 = {
      bgp_asn    = 65112
      ip_address = "1.2.3.4"
    },
    IP2 = {
      bgp_asn    = 65220
      ip_address = "172.83.124.11"
    }
  }
  */

  ##--> DHCP OPTIONS <--##
  enable_dhcp_options              = true
  dhcp_options_domain_name         = "${var.private_domain_name}"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  #dhcp_options_domain_name_servers = ["AmazonProvidedDNS", join(", ", aws_route53_resolver_endpoint.inbound.ip_address.*.ip)]

  # VPC endpoint for S3
  enable_s3_endpoint = true
 
  #############
  ## TAGGING ##
  #############
  vpc_endpoint_tags = merge(local.tags)

  tags = merge(
    # { "kubernetes.io/cluster/${var.eks["cluster_name"]}" = "shared" }, // Enable this is EKS going to be used
    local.tags
  )

  public_subnet_tags = {
    Tier = "Public"
    # "kubernetes.io/cluster/${var.eks["cluster_name"]}" = "shared" // Enable this is EKS going to be used
    # "kubernetes.io/role/elb"                           = "1"      // Enable this is EKS going to be used
  }

  private_subnet_tags = {
    Tier = "Private"
    # "kubernetes.io/cluster/${var.eks["cluster_name"]}" = "shared" // Enable this is EKS going to be used
    # "kubernetes.io/role/internal-elb"                  = "1"      // Enable this is EKS going to be used
  }
}

# Further reading https://github.com/terraform-aws-modules/terraform-aws-vpc