
module "vpc" {
  source             = "../modules/terraform-aws-vpc"
  vpc_name           = var.vpc_name
  aws_region         = var.aws_region
  cidr_block         = var.cidr_block
  az_count           = var.az_count
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  db_subnets         = var.db_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_s3_endpoint = var.enable_s3_endpoint
  tags               = var.tags
  vpc_id             = var.vpc_id
}