#
# Workstation External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local workstation to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#

provider "http" {
  version = ">= 1.1"
}

data "http" "get-external-ip" {
  url = "http://ipecho.net/plain"
}

# Override with variable or hardcoded value if necessary
locals {
  external_ip = "${chomp(data.http.get-external-ip.body)}/32"
}

output "my-external-ip" {
  value = "${local.external_ip}"
}