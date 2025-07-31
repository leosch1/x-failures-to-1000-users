
variable "allowed_origin" {
  description = "CORS origin for the Lambda function"
  type        = string
  default     = "http://localhost:3000"
}
