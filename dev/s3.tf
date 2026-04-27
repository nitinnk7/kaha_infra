module "test_data_bucket" {
  source = "../modules/terraform-aws-s3-bucket"

  bucket_name = "${local.name}-test-data"
  purpose     = "test-data-storage"

  common_tags = local.common_tags

  enable_versioning = true

  enable_lifecycle          = false
  lifecycle_transition_days = var.s3_lifecycle_glacier_transition_days # defaults to 30 days
  lifecycle_storage_class   = "GLACIER"
  lifecycle_expiration_days = var.s3_lifecycle_expiration_days # defaults to 365 days

  enable_logging = false
  logging_bucket = "" # Add logging bucket ARN if logging is enabled
  logging_prefix = ""

  attach_policy = true

  bucket_policy = data.aws_iam_policy_document.s3_bucket_policy.json

}