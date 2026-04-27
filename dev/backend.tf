# terraform {
#   required_version = ">= 1.5.0"

#   backend "s3" {
#     bucket         = "my-terraform-state-bucket-123"   # your S3 bucket
#     key            = "dev/terraform.tfstate"           # path inside bucket
#     region         = "ap-south-1"                      # your AWS region
#     dynamodb_table = "terraform-lock-table"            # DynamoDB table
#     encrypt        = true                              # enable encryption
#   }
# }