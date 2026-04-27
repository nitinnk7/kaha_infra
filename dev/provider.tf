# terraform {
#   backend "s3" {
#     #  bucket         = "smartsevak-terraform-state-apsouth1"
#     #  key            = "staging/network/terraform.tfstate"
#     #  region         = "ap-south-1"
#     #  encrypt        = true
#     #  dynamodb_table = "smartsevak-terraform-locks"
#     #  kms_key_id     = "alias/terraform-state"
#   }

#   required_version = ">= 1.5.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = "~> 3.6"
#     }
#   }
# }

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "DevOps"
    }
  }
}

