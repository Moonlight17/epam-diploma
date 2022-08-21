terraform {
  backend "s3" {
    bucket = "my-epam-diploma-bucket-serov"
    key    = "tf-states/nodegroups-state.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config  = {
    bucket = "my-epam-diploma-bucket-serov"
    key    = "tf-states/eks-state.tfstate"
    region = "eu-central-1"
  }
}

# Retrieve EKS cluster configuration
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_security_group" "sg_id" {
  id = data.terraform_remote_state.eks.outputs.cluster_security_group_id
}
