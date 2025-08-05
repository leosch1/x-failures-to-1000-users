### Lambda Function for /userCounts ###

module "lambda_user_count" {
  source                        = "terraform-aws-modules/lambda/aws"
  version                       = "~> 8.0"
  function_name                 = "user-count"
  handler                       = "handler.lambda_handler"
  runtime                       = "python3.12"
  source_path                   = "../../../backend/lambdas/user-count"
  architectures                 = ["arm64"]
  create_package                = true
  package_type                  = "Zip"
  create_role                   = true
  attach_cloudwatch_logs_policy = true
  environment_variables = {
    ALLOWED_ORIGIN  = var.allowed_origin
    POSTHOG_API_KEY = var.posthog_api_key
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_user_count.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET/userCounts"
}
