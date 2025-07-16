output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.frontend.domain_name}"
}

output "frontend_domain" {
  value = aws_route53_record.frontend.fqdn
}
