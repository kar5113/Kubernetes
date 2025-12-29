locals{
    common_name_suffix = "${var.project}-${var.environment}"
    
    ingress_alb_sg_id = data.aws_ssm_parameter.ingress_alb_sg_id.value

    public_subnet_cidrs = split(",", data.aws_ssm_parameter.public_subnet_cidrs.value)

    common_tags = {
            Project     = var.project
            Environment = var.environment
            Terraform   = "true"
        }
        
    ingress_alb_certificate_arn = data.aws_ssm_parameter.ingress_alb_certificate_arn.value
}