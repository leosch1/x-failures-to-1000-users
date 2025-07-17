output "api_gateway_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "api_gateway_stage" {
  value = aws_api_gateway_stage.default.stage_name
}

output "api_url" {
  value = aws_api_gateway_stage.default.invoke_url
}
