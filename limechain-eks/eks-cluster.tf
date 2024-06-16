module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name    =  local.cluster_name
  cluster_version = "1.27"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  cluster_endpoint_public_access  = true

  node_groups_defaults = {
    ami_type = "AL2_x86_64"
  }
  worker_groups = [
    {
      name         = "master-node-group"
      instance_types = ["t2.medium"]
      additional_security_group_ids = [aws_security_group.worker_group_one.id]
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
