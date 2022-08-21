module "eks_managed_node_group" {
    source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

    cluster_name    = data.aws_eks_cluster.cluster.name
    cluster_version = "1.21"
    name            = "micro"
    ami_type        = "AL2_x86_64"

    min_size     = 1
    max_size     = 4
    desired_size = 1

    instance_types = ["t3.medium"]
    capacity_type  = "SPOT"
    disk_size      = 20

    create_launch_template       = false
    iam_role_attach_cni_policy   = true
    create_security_group        = false
    vpc_security_group_ids       = [data.terraform_remote_state.eks.outputs.nodes_sg]
    subnet_ids                   = data.terraform_remote_state.eks.outputs.private_subnets
    iam_role_additional_policies = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]

    update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
    }

    tags = {
        ExtraTag = "micro instances"
    }
}
