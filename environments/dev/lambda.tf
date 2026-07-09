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