terraform {
  backend "s3" {
    bucket = "my-epam-diploma-bucket-serov"
    key    = "tf-states/eks-state.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.region
}


# resource "aws_eks_node_group" "example" {
#   cluster_name    = local.cluster_name
#   node_group_name = "epam-diploma"
#   node_role_arn   = "all_worker_management_"
#   subnet_ids      = module.vpc.private_subnets

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 2
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }