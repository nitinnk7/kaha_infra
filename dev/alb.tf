module "alb" {
  source = "../modules/terraform-aws-alb"

  name    = "${var.project}-alb"
  vpc_id  = var.vpc_id
  subnets = var.public_subnets

  ingress_rules = [
    {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  enable_https = false
  certificate_arn = [] # Add certificate ARN if HTTPS is enabled
  enable_access_logs = false
  log_bucket         = [] # Add log bucket ARN if access logs are enabled

  common_tags = local.common_tags
}  