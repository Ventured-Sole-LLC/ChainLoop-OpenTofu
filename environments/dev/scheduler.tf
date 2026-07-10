resource "aws_scheduler_schedule" "sla_checker_schedule" {
  name       = "dev-ChainLoop-sla-checker-schedule"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(5 minutes)"

  target {
    arn      = aws_lambda_function.sla_checker.arn
    role_arn = aws_iam_role.sla_checker_scheduler_role.arn
  }
}

resource "aws_iam_role" "sla_checker_scheduler_role" {
  name = "dev-ChainLoopSlaCheckerSchedulerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "sla_checker_scheduler_invoke" {
  name = "dev-ChainLoopSlaCheckerSchedulerInvokePolicy"
  role = aws_iam_role.sla_checker_scheduler_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "lambda:InvokeFunction"
      Resource = aws_lambda_function.sla_checker.arn
    }]
  })
}