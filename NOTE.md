

# BASE ENV FOR TEST

## Terraform Commands
```bash
rm -rf .terraform && terraform fmt && terraform init -backend=false -force-copy -get=true -input=false -lock=true -reconfigure
terraform validate
terraform plan -lock=true -refresh=true -var-file="./env/devops.tfvars"
terraform apply -lock=true -auto-approve -var-file="./env/devops.tfvars"
terraform destroy -lock=true -auto-approve -refresh=true -var-file="./env/devops.tfvars"
```

## Terraform Upgrade note from ver 0.11.10 to 0.12.18
1. We need to apply using terraform version 0.11.14 first then 0.12.18. This is safest way to apply before jump to version 12
2. We need to download latest module to our git repo. But need to discuss how we want to archive this. via tagging or create new branch 0.12.x/...
3. Reference: https://www.terraform.io/upgrade-guides/0-12.html

## Kubernetes / EKS
### Get nodes
`kubectl --kubeconfig $(terraform output kubeconfig_file) get nodes`

### Kubeconfig
To specify which aws credential should be use, copy the env: section and paste it into the kubeconfig file by following example below
```yaml
users:
- name: <cluster_name>
  user:
    exec:
      apiVersion: ...
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "sms-eks-01"
      env:
      - name: AWS_PROFILE
        value: default
```

### RDS SSL Certs
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html