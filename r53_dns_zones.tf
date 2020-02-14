###################
### Public Zone ###
###################

resource "aws_route53_zone" "main_public" {
  name = var.public_domain_name
  tags = merge(local.tags)
}
##-> Public Zone END ##

####################
### Private Zone ###
####################

resource "aws_route53_zone" "main_private" {
  name = var.private_domain_name

  # NOTE: The aws_route53_zone vpc argument accepts multiple configuration
  #       blocks. The below usage of the single vpc configuration, the
  #       lifecycle configuration.
  vpc {
    vpc_id = module.vpc01.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = merge(local.tags)
}

resource "aws_route53_record" "main_private_ns" {
  zone_id = aws_route53_zone.main_public.zone_id
  name    = var.private_domain_name
  type    = "NS"
  ttl     = "300"

  records = [
    "${aws_route53_zone.main_private.name_servers.0}",
    "${aws_route53_zone.main_private.name_servers.1}",
    "${aws_route53_zone.main_private.name_servers.2}",
    "${aws_route53_zone.main_private.name_servers.3}",
  ]
}
##-> Private Zone END ##