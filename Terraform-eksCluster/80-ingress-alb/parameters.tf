resource "aws_ssm_parameter" "this" {
  name  = "/${var.project}/${var.environment}/ingress_alb_arn"  
  type  = "String"
  value = aws_lb_listener.ingress_alb.arn
  overwrite= true
}