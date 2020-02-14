module "main-sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.4.0"
  name        = "main-sg"
  description = "Main Security Group"
  vpc_id      = module.vpc01.vpc_id

  ###################
  ## INGRESS RULES ##
  ###################

  ### Self Ingress Rules
  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  ### Computed Ingress Rules
  /*computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${module.sub-02-sg.this_security_group_id}"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1*/

  ### Normal Ingress Rules
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH"
      cidr_blocks = "${local.external_ip}"
    },
  ]

  ##################
  ## EGRESS RULES ##
  ##################
  # Nil

  ##########
  ## Tags ##
  ##########
  tags = merge(
    local.tags,
    { Name = "main-sg" }
  )
}