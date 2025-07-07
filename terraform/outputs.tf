# output "cloudfront_url" {
#   value = "https://${aws_cloudfront_distribution.frontend.domain_name}"
# }

# output "s3_bucket_name" {
#   value = aws_s3_bucket.frontend.bucket
# }

# output "cloudfront_distribution_id" {
#   value = aws_cloudfront_distribution.frontend.id
# }

# output "rds_endpoint" {
#   value = aws_db_instance.postgres.address
# }

# output "ecs_service_name" {
#   value = aws_ecs_service.api.name
# }

# output "github_actions_access_key_id" {
#   value = aws_iam_access_key.github.id
# }

# output "github_actions_secret_access_key" {
#   value     = aws_iam_access_key.github.secret
#   sensitive = true
# }

# output "frontend_domain" {
#   value = aws_route53_record.frontend.fqdn
# }

# output "backend_domain" {
#   value = aws_route53_record.backend.fqdn
# }
