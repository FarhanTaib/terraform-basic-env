# Cheetah DevOps SSH Key for Root only 
# Bastion
resource "aws_key_pair" "devops" {
  key_name   = "devops"
  public_key = "your key pairs here"
}