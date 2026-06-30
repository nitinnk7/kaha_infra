module "s3_bucket" {
  source = "../modules/terraform-aws-s3-bucket/"

  create_bucket = true
  bucket        = "<Name of the S3 Bucket>"
  acl           = var.acl # default = private

  versioning = {
    enabled    = true
    mfa_delete = false
  }

}