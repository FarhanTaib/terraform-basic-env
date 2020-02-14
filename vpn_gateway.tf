# Refer https://github.com/terraform-aws-modules/terraform-aws-vpn-gateway

/*
module "vpn_gateway01" {
  source  = "terraform-aws-modules/vpn-gateway/aws"
  version = "~> 2.0"

  vpc_id                  = module.vpc01.vpc_id
  vpn_gateway_id          = module.vpc01.vgw_id
  customer_gateway_id     = module.vpc01.cgw_ids[0]

  # precalculated length of module variable vpc_subnet_route_table_ids
  vpc_subnet_route_table_count = 3
  vpc_subnet_route_table_ids   = module.vpc.private_route_table_ids

  # tunnel inside cidr & preshared keys (optional)
  tunnel1_inside_cidr   = var.custom_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.custom_tunnel2_inside_cidr
  tunnel1_preshared_key = var.custom_tunnel1_preshared_key
  tunnel2_preshared_key = var.custom_tunnel2_preshared_key
}
*/