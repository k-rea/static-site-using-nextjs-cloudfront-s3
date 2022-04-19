resource "random_string" "s3_bucket_postfix" {
  length  = 12
  special = false
  upper   = false
  number  = false
}


resource "aws_s3_bucket" "website" {
  bucket        = "${var.name}-website-${random_string.s3_bucket_postfix.result}"
  acl           = "private"
  force_destroy = true # false when production
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website.json
}

data "aws_iam_policy_document" "website" {
  statement {
    sid = "Allow CloudFront"
    effect = "Allow"
    principals {
      identifiers = [aws_cloudfront_origin_access_identity.website.iam_arn]
      type        = "AWS"
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.website.arn}/*"
    ]
  }
}