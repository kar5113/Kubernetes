# after upgrade of cluster from aws console , update the cluster version here and 
# comment or remove the blue node group and remove the taint from green node group to make it active

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"       # Module version

  name               = local.common_name_suffix
  kubernetes_version = "1.32"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
    metrics-server        = { }
  }

  # Optional
  endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_cidrs
  control_plane_subnet_ids = local.private_subnet_cidrs
  create_node_security_group = false
  create_security_group = false
  security_group_id = local.cluster_security_group_id
  node_security_group_id   = local.node_security_group_id



  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    blue = {

      #create = true

      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small", "t3.medium","t3.micro"]
      iam_role_additional_policies = {
        efs = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ebs = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
    # blue green deployment strategy. done for upgrading node groups with zero downtime
    green = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small", "t3.medium","t3.micro"]
      iam_role_additional_policies = {
        efs = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ebs = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      min_size     = 2
      max_size     = 10
      desired_size = 2
      # Adding a taint to the nodes in the green node group to prevent scheduling of pods on them until the upgrade is complete
      taints = {
       upgrade={
        key    = "upgrade"
        value  = "true"
        effect = "NO_SCHEDULE"
       }
      } 
    }
  }



  tags = merge(
    local.common_tags,
    {
      Name = local.common_name_suffix
    }
  )
}