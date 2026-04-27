data "aws_iam_policy_document" "s3_bucket_policy" {

  # EC2 access
  statement {
    sid = "EC2Access"

    actions = ["s3:GetObject", "s3:PutObject"]

    principals {
      type        = "AWS"
      identifiers = [module.ec2.iam_role_arn]
    }

    resources = ["${module.test_data_bucket.bucket_arn}/*"]
  }

}