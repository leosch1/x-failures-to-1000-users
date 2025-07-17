resource "aws_api_gateway_rest_api" "this" {
  name        = "x-failures-to-1000-users"
  description = "API Gateway v1 for x-failures-to-1000-users"
}

data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  path        = "/"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.user_count,
      aws_api_gateway_integration.user_count_integration,
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

### Endpoint for /userCount ###

resource "aws_api_gateway_resource" "user_count" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = data.aws_api_gateway_resource.root.id
  path_part   = "userCount"
}

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
