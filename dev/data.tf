
# data "terraform_remote_state" "network" {
#   backend = "s3"

#   config = {
#     bucket = ""
#     key    = ""
#     region = ""
#   }
# }

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
