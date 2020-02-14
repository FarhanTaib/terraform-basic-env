resource "tls_private_key" "this" {
  count     = var.key_name != "" ? 0 : 1
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this_generated_key" {
  count      = var.key_name != "" ? 0 : 1
  key_name   = "tf-autogen-key"
  public_key = tls_private_key.this.*.public_key_openssh[0]
  depends_on = [tls_private_key.this]
}