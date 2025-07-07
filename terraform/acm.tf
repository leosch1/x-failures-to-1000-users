resource "aws_acm_certificate" "frontend" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  provider          = aws.us_east_1

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_route53_record" "frontend_validation" {
#   name    = tolist(aws_acm_certificate.frontend.domain_validation_options)[0].resource_record_name
#   type    = tolist(aws_acm_certificate.frontend.domain_validation_options)[0].resource_record_type
#   zone_id = data.aws_route53_zone.primary.zone_id
#   records = [tolist(aws_acm_certificate.frontend.domain_validation_options)[0].resource_record_value]
#   ttl     = 60
# }

# resource "aws_acm_certificate_validation" "frontend" {
#   certificate_arn         = aws_acm_certificate.frontend.arn
#   validation_record_fqdns = [aws_route53_record.frontend_validation.fqdn]
#   provider                = aws.us_east_1
# }
