resource "aws_apigatewayv2_api" "chainloop_api" {
  name          = "dev-ChainLoop-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Authorization", "Content-Type"]
    max_age       = 300
  }
}

resource "aws_apigatewayv2_authorizer" "chainloop_cognito_authorizer" {
  api_id           = aws_apigatewayv2_api.chainloop_api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "dev-ChainLoop-cognito-authorizer"

  jwt_configuration {
    audience = [aws_cognito_user_pool_client.chainloop_web.id]
    issuer   = "https://cognito-idp.us-east-2.amazonaws.com/${aws_cognito_user_pool.chainloop_users.id}"
  }
}

resource "aws_apigatewayv2_stage" "chainloop_default" {
  api_id      = aws_apigatewayv2_api.chainloop_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "specimen_collected_integration" {
  api_id                 = aws_apigatewayv2_api.chainloop_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.specimen_collected.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "specimen_collected_route" {
  api_id             = aws_apigatewayv2_api.chainloop_api.id
  route_key          = "POST /specimens/collect"
  target             = "integrations/${aws_apigatewayv2_integration.specimen_collected_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.chainloop_cognito_authorizer.id
}

resource "aws_lambda_permission" "specimen_collected_apigw" {
  statement_id  = "AllowAPIGatewayInvokeSpecimenCollected"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.specimen_collected.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chainloop_api.execution_arn}/*/*"
}

output "dev_chainloop_api_invoke_url" {
  value = aws_apigatewayv2_api.chainloop_api.api_endpoint
}
resource "aws_apigatewayv2_integration" "courier_accepted_integration" {
  api_id                 = aws_apigatewayv2_api.chainloop_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.courier_accepted.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "courier_accepted_route" {
  api_id             = aws_apigatewayv2_api.chainloop_api.id
  route_key          = "POST /specimens/accept"
  target             = "integrations/${aws_apigatewayv2_integration.courier_accepted_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.chainloop_cognito_authorizer.id
}

resource "aws_lambda_permission" "courier_accepted_apigw" {
  statement_id  = "AllowAPIGatewayInvokeCourierAccepted"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.courier_accepted.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chainloop_api.execution_arn}/*/*"
}
resource "aws_apigatewayv2_integration" "courier_status_update_integration" {
  api_id                 = aws_apigatewayv2_api.chainloop_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.courier_status_update.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "courier_status_update_route" {
  api_id             = aws_apigatewayv2_api.chainloop_api.id
  route_key          = "POST /specimens/status"
  target             = "integrations/${aws_apigatewayv2_integration.courier_status_update_integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.chainloop_cognito_authorizer.id
}

resource "aws_lambda_permission" "courier_status_update_apigw" {
  statement_id  = "AllowAPIGatewayInvokeCourierStatusUpdate"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.courier_status_update.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.chainloop_api.execution_arn}/*/*"
}