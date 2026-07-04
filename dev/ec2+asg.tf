module "ec2-on-demand" {
  source = "../modules/terraform-aws-ec2+asg"

  name    = "${var.project}-primary-instance"
  vpc_id  = var.vpc_id
  subnets = var.private_subnets_asg

  ami = "ami-12345678" # Replace with actual AMI ID for your region

  instance_type    = var.ec2_instance_type
  instance_types   = [var.ec2_instance_type] # Only one instance type for on-demand
  min_size         = var.min_size_asg
  max_size         = var.max_size_asg
  desired_capacity = var.desired_capacity_asg
  cpu_target_value = var.cpu_target_value_asg

  target_group_arns = [module.alb.target_group_arn]

  ingress_rules = [
    {
      port            = 80
      security_groups = [module.alb.security_group_id]
      description     = "Allow ALB traffic"
    }
  ]

  common_tags = local.common_tags
}

module "ec2-spot" {
  source = "../modules/terraform-aws-ec2+asg"

  name    = "${var.project}-spot-instance"
  vpc_id  = var.vpc_id
  subnets = var.private_subnets_asg

  ami = "ami-12345678" # Replace with actual AMI ID for your region

  instance_type    = var.ec2_instance_type_spot
  instance_types   = var.ec2_instance_types_spot
  min_size         = var.min_size_asg_spot
  max_size         = var.max_size_asg_spot
  desired_capacity = var.desired_capacity_asg_spot
  cpu_target_value = var.cpu_target_value_asg_spot

  target_group_arns = [module.alb.target_group_arn]

  ingress_rules = [
    {
      port            = 80
      security_groups = [module.alb.security_group_id]
      description     = "Allow ALB traffic"
    }
  ]

  common_tags = local.common_tags
}