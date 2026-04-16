# EKS Managed Node Group - Private Subnets
resource "aws_eks_node_group" "private_nodes" {

  # The name of the EKS cluster this node grou belongs to
  cluster_name = aws_eks_cluster.main.name

  # Logical name for this node group in the EKS cluster
  node_group_name = "${local.eks_cluster_name}-private-ng"

  # IAM role that EC2 worker nodes will assume
  node_role_arn = aws_iam_role.eks_nodegroup_role.arn

  # Subnets where the worker nodes will be launched
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  # Instance types for the nodes 
  instance_types = var.node_instance_types

  # capacity type : ON_DEMAND or SPOT
  capacity_type = var.node_capacity_type

  ami_type = "AL2023_x86_64_STANDARD"

  # Root volume size for each node in GiB
  disk_size = var.node_disk_size

  # Configure auto-scaling limits and defaults
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Set the max percentage of nodes that can be unavailable during update
  update_config {
    max_unavailable = 33
  }

  # Force node group update when EKS AMI version changes
  force_update_version = true

  # Apply labels to each EC2 instance for easier scheduling and management in k8s
  labels = {
    "env"  = var.environment_name
    "team" = var.business_division
  }

  tags = merge(var.tags, {
    Environment = var.environment_name
  })

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy,
  ]
}