data "aws_iam_policy_document" "chainloop_lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "specimen_collected_lambda_role" {
  name               = "dev-ChainLoopSpecimenCollectedLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.chainloop_lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "specimen_collected_basic_execution" {
  role       = aws_iam_role.specimen_collected_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "specimen_collected_permissions" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem"]
    resources = [aws_dynamodb_table.chainloop_event_log.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem"]
    resources = [aws_dynamodb_table.chainloop_projection.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["events:PutEvents"]
    resources = [aws_cloudwatch_event_bus.chainloop_events.arn]
  }
}

resource "aws_iam_role_policy" "specimen_collected_permissions" {
  name   = "dev-ChainLoopSpecimenCollectedPolicy"
  role   = aws_iam_role.specimen_collected_lambda_role.id
  policy = data.aws_iam_policy_document.specimen_collected_permissions.json
}
resource "aws_iam_role" "courier_accepted_lambda_role" {
  name               = "dev-ChainLoopCourierAcceptedLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.chainloop_lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "courier_accepted_basic_execution" {
  role       = aws_iam_role.courier_accepted_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "courier_accepted_permissions" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem"]
    resources = [aws_dynamodb_table.chainloop_event_log.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:UpdateItem"]
    resources = [aws_dynamodb_table.chainloop_projection.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["events:PutEvents"]
    resources = [aws_cloudwatch_event_bus.chainloop_events.arn]
  }
}

resource "aws_iam_role_policy" "courier_accepted_permissions" {
  name   = "dev-ChainLoopCourierAcceptedPolicy"
  role   = aws_iam_role.courier_accepted_lambda_role.id
  policy = data.aws_iam_policy_document.courier_accepted_permissions.json
}
resource "aws_iam_role" "courier_status_update_lambda_role" {
  name               = "dev-ChainLoopCourierStatusUpdateLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.chainloop_lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "courier_status_update_basic_execution" {
  role       = aws_iam_role.courier_status_update_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "courier_status_update_permissions" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem"]
    resources = [aws_dynamodb_table.chainloop_event_log.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:UpdateItem"]
    resources = [aws_dynamodb_table.chainloop_projection.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["events:PutEvents"]
    resources = [aws_cloudwatch_event_bus.chainloop_events.arn]
  }
}

resource "aws_iam_role_policy" "courier_status_update_permissions" {
  name   = "dev-ChainLoopCourierStatusUpdatePolicy"
  role   = aws_iam_role.courier_status_update_lambda_role.id
  policy = data.aws_iam_policy_document.courier_status_update_permissions.json
}