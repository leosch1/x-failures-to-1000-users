data "aws_route53_zone" "primary" {
  name         = "schleo.com"
  private_zone = false
}

resource "aws_acm_certificate" "api" {
  provider          = aws.us_east_1
  domain_name       = "api.schleo.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "api_validation" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = tolist(aws_acm_certificate.api.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.api.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.api.domain_validation_options)[0].resource_record_value]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "api" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.api.arn
  validation_record_fqdns = [aws_route53_record.api_validation.fqdn]
}

resource "aws_api_gateway_domain_name" "custom" {
  domain_name     = "api.schleo.com"
  certificate_arn = aws_acm_certificate_validation.api.certificate_arn
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_base_path_mapping" "custom" {
  api_id      = module.backend.api_gateway_id
  stage_name  = module.backend.api_gateway_stage
  domain_name = aws_api_gateway_domain_name.custom.domain_name
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "api.schleo.com"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.custom.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.custom.cloudfront_zone_id
    evaluate_target_health = false
  }
}
