variable "alert_email" {
  type        = string
  description = "Email address for ChainLoop operational alerts"
  sensitive   = true
  default     = "placeholder@example.com"
}

resource "aws_sns_topic" "chainloop_alerts" {
  name = "dev-ChainLoop-alerts"
}

resource "aws_sns_topic_subscription" "chainloop_alerts_email" {
  topic_arn = aws_sns_topic.chainloop_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}