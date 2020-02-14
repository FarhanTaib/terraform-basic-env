module "bastion" {
  source                 = "./modules/multi_ec2"
  instance_count         = 0
  instance_name          = "bastion"
  r53_zone_id            = aws_route53_zone.main_private.zone_id
  vpc_security_group_ids = [module.main-sg.this_security_group_id]
  subnet_id              = module.vpc01.public_subnets
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops.key_name
  private_key            = file("~/.ssh/id_rsa")
  #ami_id =
  #ami_username = ""
  tags = local.tags
}

output "ec2_private_ip" {
  value = module.bastion.ec2_private_ip
}

output "ec2_public_ip" {
  value = module.bastion.ec2_public_ip
}