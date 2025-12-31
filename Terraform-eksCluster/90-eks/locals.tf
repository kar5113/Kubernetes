locals{
    common_name_suffix = "${var.project}-${var.environment}"
    
    vpc_id = data.aws_ssm_parameter.vpc_id.value



    private_subnet_cidrs = split(",", data.aws_ssm_parameter.private_subnet_cidrs.value)

    cluster_security_group_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value

    node_security_group_id = data.aws_ssm_parameter.eks_nodegroup_sg_id.value

    common_tags = {
            Project     = var.project
            Environment = var.environment
            Terraform   = "true"
        }
        
 
}