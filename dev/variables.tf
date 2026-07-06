# Resources Project - Variables

#################
# General
#################
variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "vpc ID"
  type        = string
  default     = ""
}



#################
# Network
#################

variable "vpc_name" {
  description = "VPC name"
  type        = string
}


variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az_count" {
  description = "Count of Availability Zones"
  type        = number
  default     = 2
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = map(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = map(string)
}

variable "db_subnets" {
  description = "List of private subnet CIDRs"
  type        = map(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "enable_s3_endpoint" {
  type    = bool
  default = true
}


#################
# RDS
#################
variable "rds_enabled" {
  description = "Enable RDS MySQL database"
  type        = bool
  default     = true
}

variable "rds_engine" {
  description = "Database engine (mysql or postgres)"
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0.39"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "rds_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 100
}

variable "rds_max_allocated_storage" {
  description = "Maximum allocated storage in GB for autoscaling"
  type        = number
  default     = 500
}

variable "rds_db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "rds_username" {
  description = "Master username"
  type        = string
  default     = "dbadmin"
}

variable "rds_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "rds_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "rds_maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "Mon:04:00-Mon:05:00"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}


variable "private_subnets_rds" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = []
}



#################
# ec2+asg
#################
variable "private_subnets_asg" {
  description = "List of private subnet IDs for ASG"
  type        = list(string)
  default     = []
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "c7g.2xlarge" # Graviton instance type
}

variable "ec2_instance_types" {
  description = "List of EC2 instance types"
  type        = list(string)
  default     = []
}
variable "min_size_asg" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 2
}

variable "max_size_asg" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 2
}

variable "desired_capacity_asg" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 2
}

variable "cpu_target_value_asg" {
  description = "Target CPU utilization percentage for ASG scaling"
  type        = number
  default     = 60

}

variable "enable_cpu_scaling_asg" {
  type    = bool
  default = false
}


variable "enable_request_count_asg" {
  description = "Enable request count based scaling"
  type        = bool
  default     = false
}

variable "request_count_target_value_asg" {
  description = "Target request count per target"
  type        = number
  default     = 1000
}
#################
# ec2+asg spot
#################
variable "private_subnets_asg_spot" {
  description = "List of private subnet IDs for ASG"
  type        = list(string)
  default     = []
}

variable "ec2_instance_type_spot" {
  description = "EC2 instance type"
  type        = string
  default     = "c7g.2xlarge" # Graviton instance type
}

variable "ec2_instance_types_spot" {
  description = "List of EC2 instance types"
  type        = list(string)
  default     = []
}
variable "min_size_asg_spot" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 2
}

variable "max_size_asg_spot" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 2
}

variable "desired_capacity_asg_spot" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 2
}

variable "cpu_target_value_asg_spot" {
  description = "Target CPU utilization percentage for ASG scaling"
  type        = number
  default     = 60

}

variable "enable_cpu_scaling_asg_spot" {
  type    = bool
  default = false
}


variable "enable_request_count_asg_spot" {
  description = "Enable request count based scaling"
  type        = bool
  default     = false
}

variable "request_count_target_value_asg_spot" {
  description = "Target request count per target"
  type        = number
  default     = 1000
}

#################
# Tags
#################
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "additional_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "s3_enable_versioning" {
  type    = bool
  default = true
}
variable "s3_lifecycle_glacier_transition_days" {
  type    = number
  default = 90
}
variable "s3_lifecycle_expiration_days" {
  type    = number
  default = 365
}

##################
#S3 Bucket
##################
variable "acl" {
  description = "The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}