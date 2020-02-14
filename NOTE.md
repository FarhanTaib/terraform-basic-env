

# BASE ENV FOR TEST

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
