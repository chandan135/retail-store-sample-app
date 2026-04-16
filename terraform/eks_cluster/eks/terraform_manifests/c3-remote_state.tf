# Datasource
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tfstate-dev-us-east-1-nc603u54npkr5plm"
    key    = "retail-store-sample-app-infra/dev/eks-cluster/vpc-module/terraform.tfstate"
    region = "us-east-1"
  }

}

# Outputs
output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "private_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}

output "public_subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.public_subnet_ids
}

