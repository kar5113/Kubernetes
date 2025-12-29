module "security_groups"{
  # source= "../../SG/module"
    source = "git::https://github.com/kar5113/Terraform-SG.git?ref=main"

   count= length(var.sg_names)
   sg_name ="${local.common_name_suffix}-${var.sg_names[count.index]}"
   sg_description = "Security groups for Roboshop application"
   vpc_id =  data.aws_ssm_parameter.vpc_id.value
   project = var.project
   environment = var.environment
}