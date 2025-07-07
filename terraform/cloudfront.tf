# resource "aws_cloudfront_origin_access_control" "frontend_oac" {
#   name                              = "vibe-radar-frontend-oac"
#   description                       = "OAC for secure access to S3 frontend bucket"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

# resource "aws_cloudfront_distribution" "frontend" {
#   enabled             = true
#   is_ipv6_enabled     = true
#   # default_root_object = "index.html" # Not needed anymore as we handle URLs with a CloudFront function

#   aliases = [var.domain_name]

#   origin {
#     domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
#     origin_id   = "s3-frontend"

#     origin_access_control_id = aws_cloudfront_origin_access_control.frontend_oac.id
#   }

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3-frontend"

#     viewer_protocol_policy = "redirect-to-https"

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     function_association {
#       event_type   = "viewer-request"
#       function_arn = aws_cloudfront_function.rewrite_to_html.arn
#     }
#   }

#   price_class = "PriceClass_100"

#   viewer_certificate {
#     acm_certificate_arn            = aws_acm_certificate_validation.frontend.certificate_arn
#     ssl_support_method             = "sni-only"
#     minimum_protocol_version       = "TLSv1.2_2021"
#     cloudfront_default_certificate = false
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }
# }

# resource "aws_cloudfront_function" "rewrite_to_html" {
#   name    = "rewrite-to-html"
#   runtime = "cloudfront-js-1.0"
#   comment = "Rewrite clean URLs to .html files"

#   code = <<EOF
# function handler(event) {
#   var request = event.request;
#   var uri = request.uri;

#   if (uri === "/") {
#     request.uri = "/index.html";
#   } else if (uri.endsWith('/')) {
#     request.uri = uri.slice(0, -1) + '.html';
#   } else if (!uri.includes('.') && uri !== '') {
#     request.uri = uri + '.html';
#   }

#   return request;
# }
# EOF
# }
