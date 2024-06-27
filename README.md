# AWS ipsec VPN terraform stack

To run them, you need [Terraform](https://www.terraform.io/) (`brew install terraform`) and AWS credentials. Also the first time you create the stack: `AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x AWS_REGION=eu-central-1 terraform -chdir=staging init`

1. `AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x AWS_REGION=eu-central-1 terraform -chdir=staging apply`
2. Or go one directory upwards, set your credentials to `.env` and use: `./ex.sh tf:apply`

```sh
./ex.sh tf init -backend-config=backend.conf

./ex.sh tf init -backend-config="bucket=${TFSTATE_BUCKET}" \
  -backend-config="key=${TFSTATE_KEY}" \
  -backend-config="region=${AWS_REGION}"
 
```

## stuff

- https://terrateam.io/blog/aws-lambda-function-with-terraform
- https://developer.hashicorp.com/terraform/tutorials/aws/lambda-api-gateway
- https://github.com/transcend-io/terraform-aws-lambda-at-edge/blob/master/main.tf
