# EDP BASE ENV FOR TEST

## Terraform Commands
```bash
rm -rf .terraform && terraform fmt && terraform init -backend=false -force-copy -get=true -input=false -lock=true -reconfigure
terraform validate
terraform plan -lock=true -refresh=true -var-file="./env/environment.tfvars"
terraform apply -lock=true -auto-approve -var-file="./env/environment.tfvars"
terraform destroy -lock=true -auto-approve -refresh=true -var-file="./env/environment.tfvars"
```
