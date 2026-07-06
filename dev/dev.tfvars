#################
# General
#################
project     = "kaha"
environment = "dev"
aws_region  = "ap-south-1"
vpc_id      = "vpc-12345678" # Replace with actual VPC ID

##################
# Network
##################
vpc_name   = "kaha-vpc"     # replace with your existing vpc name
cidr_block = "10.10.0.0/16" # replace with your vpc CIDR block
az_count   = 2              # Replace the number of availability zones according to your region. Do not exceed the number of availability zones in your region
public_subnets = {
  kaha-public-subnet-01 = "10.10.0.0/21"
  kaha-public-subnet-02 = "10.10.8.0/21"
}

private_subnets = {
  kaha-private-subnet-01 = "10.10.32.0/19"
  kaha-private-subnet-02 = "10.10.64.0/19"
}
db_subnets = {
  kaha-db-subnet-01 = "10.10.96.0/26"
  kaha-db-subnet-02 = "10.10.96.64/26"
}

enable_nat_gateway = true
enable_s3_endpoint = true

enable_peering = true

################
# EC2 + ASG on demand
################
ec2_instance_type              = "c7g.2xlarge" # Primary instance type on demand
ec2_instance_types             = []            # use only one instance type for on-demand
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
