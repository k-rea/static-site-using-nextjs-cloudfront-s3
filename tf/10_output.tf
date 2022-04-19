output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.website.domain_name
}

output "s3_website_bucket_name" {
  value = aws_s3_bucket.website.bucket
}