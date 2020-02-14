

resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon-linux-2.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name != "" ? var.key_name : aws_key_pair.this_generated_key.*.key_name[0]
  monitoring             = false
  vpc_security_group_ids = var.vpc_security_group_ids
  #subnet_id                   = module.vpc01.public_subnets[element(["0", "1", "2"], count.index)]
  subnet_id                   = var.subnet_id[element(range(length(var.subnet_id)), count.index)]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = merge(
    var.tags,
    { "Name" = "${var.instance_name}-${count.index}" }
  )

  volume_tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}

## Provisioner
resource "null_resource" "connect_this" {
  count = var.instance_count

  triggers = {
    aws_instance_state = aws_instance.this.*.instance_state[count.index] != "running" ? "unknown" : "running"
  }

  connection {
    host        = aws_instance.this.*.public_ip[count.index]
    user        = var.ami_id != "" ? var.ami_username : "ec2-user"
    private_key = var.key_name != "" ? var.private_key : tls_private_key.this.*.private_key_pem[0]

  }

  provisioner "remote-exec" {
    inline = ["echo 'CONNECTED to ${var.instance_name}-${count.index}!'"]
  }

  depends_on = [aws_instance.this]
}

## Register DNS
resource "aws_route53_record" "this_hostname" {
  count   = var.instance_count
  zone_id = var.r53_zone_id
  name    = "${var.instance_name}-${count.index}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.this.*.private_ip[count.index]}"]
}