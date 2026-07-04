#################
# General
#################
project        = "kaha"
environment    = "dev"
aws_region     = "ap-south-1"
vpc_id         = "vpc-12345678"                         # Replace with actual VPC ID
public_subnets = ["subnet-12345678", "subnet-87654321"] # Replace with actual public subnet IDs for alb

################
# EC2 + ASG on demand
################
ec2_instance_type              = "c7g.2xlarge"                          # Primary instance type on demand
ec2_instance_types             = []                                     # use only one instance type for on-demand
private_subnets_asg            = ["subnet-12345678", "subnet-87654321"] # Replace with actual private subnet IDs for ASG
max_size_asg                   = 2
min_size_asg                   = 2
desired_capacity_asg           = 2
enable_cpu_scaling_asg         = true
cpu_target_value_asg           = 60
enable_request_count_asg       = false
request_count_target_value_asg = 1000

################
# EC2 + ASG spot
################
ec2_instance_type_spot              = "c7g.2xlarge"                                  # Primary instance type spot
ec2_instance_types_spot             = ["c7g.2xlarge", "c6g.2xlarge", "c6gn.2xlarge"] # spot instance types for ASG
private_subnets_asg_spot            = ["subnet-12345678", "subnet-87654321"]         # Replace with actual private subnet IDs for ASG
max_size_asg_spot                   = 20
min_size_asg_spot                   = 1
desired_capacity_asg_spot           = 1
enable_cpu_scaling_asg_spot         = true
cpu_target_value_asg_spot           = 60
enable_request_count_asg_spot       = false
request_count_target_value_asg_spot = 1000

#################
# RDS MySQL
#################
rds_enabled                 = true
vpc_id_for_rds              = "value"
rds_engine                  = "mysql"
rds_engine_version          = "8.0"
rds_instance_class          = "R8g.4xLarge"
rds_allocated_storage       = 100
rds_max_allocated_storage   = 500
rds_db_name                 = "appdb"
rds_username                = "dbadmin"
rds_backup_retention_period = 7
rds_backup_window           = "03:00-04:00"
rds_maintenance_window      = "Mon:04:00-Mon:05:00"
rds_multi_az                = false
rds_skip_final_snapshot     = true
private_subnets_rds         = ["subnet-12345678", "subnet-87654321"] # Replace with actual private subnet IDs for RDS



#################
# Tags
#################
tags = {
  Terraform   = "true"
  Environment = "dev"
}

additional_tags = {
  Project    = "Kaha"
  Owner      = "DevOps Team"
  CostCenter = "Engineering"
  ManagedBy  = "Terraform"
}
