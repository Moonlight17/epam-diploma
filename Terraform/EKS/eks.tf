module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.20.5"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnet_ids      = module.vpc.private_subnets
  # subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_enabled_log_types       = []
  create_cloudwatch_log_group     = false
  
# EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    # disk_size      = 50
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    # blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
    }
  }
  tags = {
    Stage = "Now"
  }

}



# module "eks_node_group" {
#   source = "cloudposse/eks-node-group/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   # version     = "x.x.x"

#   instance_types        = [var.instance_type]
#   subnet_ids            = module.subnets.public_subnet_ids
#   min_size              = var.min_size
#   max_size              = var.max_size
#   cluster_name          = module.eks_cluster.eks_cluster_id
#   create_before_destroy = true


#   # Enable the Kubernetes cluster auto-scaler to find the auto-scaling group
#   cluster_autoscaler_enabled = var.autoscaling_policies_enabled

#   context = module.label.context

#   # Ensure the cluster is fully created before trying to add the node group
#   # module_depends_on = [module.eks_cluster.kubernetes_config_map_id]
# }

