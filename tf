#!/bin/bash
#export TF_LOG=TRACE
#export TF_LOG_PATH=./terraform.log
export TF_CLI_ARGS_init="-backend=true -force-copy -get=true -input=false -lock=true -reconfigure"
export TF_CLI_ARGS_plan="-lock=true -refresh=true -var-file=./env/devops.tfvars"
#export TF_CLI_ARGS_apply="-lock=true -auto-approve -var-file=./env/devops.tfvars"
export TF_CLI_ARGS_apply="-lock=true -var-file=./env/devops.tfvars"
export TF_CLI_ARGS_destroy="-lock=true -var-file=./env/devops.tfvars"
#export KUBECONFIG="$(terraform output kubeconfig_file 2> /dev/null)"

rm -rf ${TF_LOG_PATH}

cd $(pwd)

init() {
    terraform fmt -recursive && terraform init
}

validate() {
    terraform validate
}

plan() {
    terraform plan
}

apply() {
    terraform apply
}

applynow() {
    terraform apply -auto-approve
}

destroy() {
    terraform destroy
}

$1