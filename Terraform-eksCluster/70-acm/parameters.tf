resource "aws_ssm_parameter" "this" {
  name  = "/${var.project}/${var.environment}/ingress_alb_certificate_arn"  
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
  overwrite= true
}