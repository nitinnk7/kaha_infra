# Local Variables for Resources Project

locals {
  # Common naming
  name     = "${var.project}-${var.environment}"
  db_name  = "${var.project}-${var.environment}-db"

  # Account information
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  # Common tags
  common_tags = merge(
    var.tags,
    var.additional_tags,
    {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
