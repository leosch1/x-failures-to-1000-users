### Lambda Function for /userCount ###

module "lambda_user_count" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "user-count"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  source_path   = "../../../backend/lambdas/user-count"

  create_role                   = true
  attach_cloudwatch_logs_policy = true
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_user_count.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/GET/userCount"
}
