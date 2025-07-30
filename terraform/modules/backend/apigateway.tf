resource "aws_api_gateway_rest_api" "this" {
  name        = "x-failures-to-1000-users"
  description = "API Gateway v1 for x-failures-to-1000-users"
}

data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  path        = "/"
}

resource "aws_api_gateway_resource" "user_count" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = data.aws_api_gateway_resource.root.id
  path_part   = "userCounts"
}

# GET Method
resource "aws_api_gateway_method" "user_count" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.user_count.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "user_count_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.user_count.id
  http_method             = aws_api_gateway_method.user_count.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_user_count.lambda_function_invoke_arn
}

# CORS - OPTIONS Method
resource "aws_api_gateway_method" "user_count_options" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.user_count.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "user_count_options_integration" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.user_count.id
  http_method = aws_api_gateway_method.user_count_options.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_method_response" "user_count_options_response" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.user_count.id
  http_method = aws_api_gateway_method.user_count_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "user_count_options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.user_count.id
  http_method = aws_api_gateway_method.user_count_options.http_method
  status_code = aws_api_gateway_method_response.user_count_options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'schleo.com'"
  }

  response_templates = {
    "application/json" = ""
  }
}

# Deployment
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.user_count,
      aws_api_gateway_integration.user_count_integration,
      aws_api_gateway_method.user_count_options,
      aws_api_gateway_integration.user_count_options_integration,
      aws_api_gateway_method_response.user_count_options_response,
      aws_api_gateway_integration_response.user_count_options_integration_response,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "default" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = "default"
}
