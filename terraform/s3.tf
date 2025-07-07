resource "aws_s3_bucket" "frontend" {
  bucket = "x-failures-to-1000-users-frontend-18792384961293"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_policy" "frontend" {
#   bucket = aws_s3_bucket.frontend.id
#   policy = data.aws_iam_policy_document.frontend_s3_policy.json
# }

# data "aws_iam_policy_document" "frontend_s3_policy" {
#   statement {
#     sid = "AllowCloudFrontServicePrincipalReadOnly"

#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudfront.amazonaws.com"]
#     }

#     actions = ["s3:GetObject"]

#     resources = [
#       "${aws_s3_bucket.frontend.arn}/*"
#     ]

#     condition {
#       test     = "StringEquals"
#       variable = "AWS:SourceArn"
#       values   = [aws_cloudfront_distribution.frontend.arn]
#     }
#   }
# }
