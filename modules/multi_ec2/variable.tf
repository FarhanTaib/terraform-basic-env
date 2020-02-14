
variable "instance_count" {
  description = "Number of instance to be created"
  default     = 0
}

variable "instance_name" {
  default = "my-instance"
}

variable "vpc_security_group_ids" {
  default = ["nil"]
}

variable "subnet_id" {}

variable "r53_zone_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = ""
}

variable "private_key" {
  default = ""
}

variable "ami_id" {
  default = ""
}

variable "ami_username" {
  default = ""
}

variable "tags" {
  default = ""
}
