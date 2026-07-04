#################
# RDS Database
#################

module "rds" {
  count  = var.rds_enabled ? 1 : 0
  source = "../modules/terraform-aws-rds"

  identifier        = local.db_name
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage

  db_name      = var.rds_db_name
  username     = var.rds_username
  rds_password = random_password.rds_master[0].result

  vpc_id         = var.vpc_id
  subnet_ids     = var.private_subnets_rds                                                     # Replace with actual private subnet IDs for RDS
  inbound_sg_ids = [module.ec2-spot.security_group_id, module.ec2-on-demand.security_group_id] # Allow EC2 instances to access RDS

  skip_final_snapshot = var.rds_skip_final_snapshot
  # Note: This module may not support all RDS parameters
  # Only basic parameters are included
}

# Random password for RDS master user
resource "random_password" "rds_master" {
  count = var.rds_enabled ? 1 : 0

  length  = 32
  special = true
  # MySQL/PostgreSQL compatible special characters
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Store RDS password in Secrets Manager
resource "aws_secretsmanager_secret" "rds_master_password" {
  count = var.rds_enabled ? 1 : 0

  name        = "${local.name}-rds-master-password"
  description = "RDS master password for ${local.name}"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "rds_master_password" {
  count = var.rds_enabled ? 1 : 0

  secret_id     = aws_secretsmanager_secret.rds_master_password[0].id
  secret_string = random_password.rds_master[0].result
}

#################
# DB Subnet Group (if not created by module)
#################

# resource "aws_db_subnet_group" "main" {
#   count = var.rds_enabled ? 1 : 0

#   name       = "${local.name}-db-subnet-group"
#   subnet_ids = var.private_subnets_rds # Replace with actual private subnet IDs for RDS

#   tags = merge(local.common_tags, {
#     Name = "${local.name}-db-subnet-group"
#   })
# }
