resource "aws_cognito_user_pool" "chainloop_users" {
  name                     = "dev-ChainLoop-users"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  mfa_configuration = "OFF"

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource "aws_cognito_user_pool_client" "chainloop_web" {
  name            = "dev-ChainLoop-web"
  user_pool_id    = aws_cognito_user_pool.chainloop_users.id
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 30
}

resource "aws_cognito_user_group" "lab_tech" {
  name         = "lab-tech"
  user_pool_id = aws_cognito_user_pool.chainloop_users.id
  description  = "Lab staff who log specimen collection"
}

resource "aws_cognito_user_group" "courier" {
  name         = "courier"
  user_pool_id = aws_cognito_user_pool.chainloop_users.id
  description  = "Couriers who accept custody, log transit, and confirm delivery"
}

resource "aws_cognito_user_group" "receiving_lab" {
  name         = "receiving-lab"
  user_pool_id = aws_cognito_user_pool.chainloop_users.id
  description  = "Receiving lab staff who confirm and verify receipt"
}

resource "aws_cognito_user_group" "ops_supervisor" {
  name         = "ops-supervisor"
  user_pool_id = aws_cognito_user_pool.chainloop_users.id
  description  = "Ops staff who monitor SLA alerts and resolve exceptions"
}
