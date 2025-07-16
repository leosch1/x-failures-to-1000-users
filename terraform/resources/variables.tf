variable "domain_name" {
  description = "The root domain name"
  type        = string
  default     = "schleo.com"
}

variable "route53_zone_id" {
  description = "The Route53 zone ID for the domain"
  type        = string
}

# variable "posthog_api_key" {
#   description = "API key for posthog"
#   type        = string
#   sensitive   = true
# }
