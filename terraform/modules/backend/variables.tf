
variable "allowed_origin" {
  description = "CORS origin for the Lambda function"
  type        = string
  default     = "http://localhost:3000"
}

variable "posthog_api_key" {
  description = "API key for PostHog"
  type        = string
  sensitive   = true
}
