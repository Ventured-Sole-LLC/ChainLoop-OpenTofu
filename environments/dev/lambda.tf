data "archive_file" "specimen_collected_zip" {
  type        = "zip"
  source_dir  = "../../../ChainLoop/lambdas/specimen-collected"
  output_path = "${path.root}/build/dev-specimencollectedlambda.zip"
}

resource "aws_lambda_function" "specimen_collected" {
  function_name    = "dev-SpecimenCollectedLambda"
  role             = aws_iam_role.specimen_collected_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  memory_size      = 128
  timeout          = 3
  filename         = data.archive_file.specimen_collected_zip.output_path
  source_code_hash = data.archive_file.specimen_collected_zip.output_base64sha256

  environment {
    variables = {
      EVENT_LOG_TABLE_NAME  = aws_dynamodb_table.chainloop_event_log.name
      PROJECTION_TABLE_NAME = aws_dynamodb_table.chainloop_projection.name
      EVENT_BUS_NAME        = aws_cloudwatch_event_bus.chainloop_events.name
    }
  }
}
data "archive_file" "courier_accepted_zip" {
  type        = "zip"
  source_dir  = "../../../ChainLoop/lambdas/courier-accepted"
  output_path = "${path.root}/build/dev-courieracceptedlambda.zip"
}

resource "aws_lambda_function" "courier_accepted" {
  function_name    = "dev-CourierAcceptedLambda"
  role             = aws_iam_role.courier_accepted_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  memory_size      = 128
  timeout          = 3
  filename         = data.archive_file.courier_accepted_zip.output_path
  source_code_hash = data.archive_file.courier_accepted_zip.output_base64sha256

  environment {
    variables = {
      EVENT_LOG_TABLE_NAME  = aws_dynamodb_table.chainloop_event_log.name
      PROJECTION_TABLE_NAME = aws_dynamodb_table.chainloop_projection.name
      EVENT_BUS_NAME        = aws_cloudwatch_event_bus.chainloop_events.name
    }
  }
}
data "archive_file" "courier_status_update_zip" {
  type        = "zip"
  source_dir  = "../../../ChainLoop/lambdas/courier-status-update"
  output_path = "${path.root}/build/dev-courierstatusupdatelambda.zip"
}

resource "aws_lambda_function" "courier_status_update" {
  function_name    = "dev-CourierStatusUpdateLambda"
  role             = aws_iam_role.courier_status_update_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  memory_size      = 128
  timeout          = 3
  filename         = data.archive_file.courier_status_update_zip.output_path
  source_code_hash = data.archive_file.courier_status_update_zip.output_base64sha256

  environment {
    variables = {
      EVENT_LOG_TABLE_NAME  = aws_dynamodb_table.chainloop_event_log.name
      PROJECTION_TABLE_NAME = aws_dynamodb_table.chainloop_projection.name
      EVENT_BUS_NAME        = aws_cloudwatch_event_bus.chainloop_events.name
    }
  }
}
data "archive_file" "lab_verified_zip" {
  type        = "zip"
  source_dir  = "../../../ChainLoop/lambdas/lab-verified"
  output_path = "${path.root}/build/dev-labverifiedlambda.zip"
}

resource "aws_lambda_function" "lab_verified" {
  function_name    = "dev-LabVerifiedLambda"
  role             = aws_iam_role.lab_verified_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  memory_size      = 128
  timeout          = 3
  filename         = data.archive_file.lab_verified_zip.output_path
  source_code_hash = data.archive_file.lab_verified_zip.output_base64sha256

  environment {
    variables = {
      EVENT_LOG_TABLE_NAME  = aws_dynamodb_table.chainloop_event_log.name
      PROJECTION_TABLE_NAME = aws_dynamodb_table.chainloop_projection.name
      EVENT_BUS_NAME        = aws_cloudwatch_event_bus.chainloop_events.name
    }
  }
}
data "archive_file" "sla_checker_zip" {
  type        = "zip"
  source_dir  = "../../../ChainLoop/lambdas/sla-checker"
  output_path = "${path.root}/build/dev-slacheckerlambda.zip"
}

resource "aws_lambda_function" "sla_checker" {
  function_name    = "dev-SlaCheckerLambda"
  role             = aws_iam_role.sla_checker_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.14"
  memory_size      = 128
  timeout          = 10
  filename         = data.archive_file.sla_checker_zip.output_path
  source_code_hash = data.archive_file.sla_checker_zip.output_base64sha256

  environment {
    variables = {
      PROJECTION_TABLE_NAME = aws_dynamodb_table.chainloop_projection.name
      SNS_TOPIC_ARN         = aws_sns_topic.chainloop_alerts.arn
      EVENT_BUS_NAME        = aws_cloudwatch_event_bus.chainloop_events.name
    }
  }
}
