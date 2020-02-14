# Cheetah DevOps SSH Key for Root only 
# Bastion
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = "your key pairs here"
}
