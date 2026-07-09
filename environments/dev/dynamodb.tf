resource "aws_dynamodb_table" "chainloop_event_log" {
  name         = "dev-ChainLoopEventLog"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "specimen_id"
  range_key    = "timestamp_event_type_event_id"

  attribute {
    name = "specimen_id"
    type = "S"
  }

  attribute {
    name = "timestamp_event_type_event_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "chainloop_projection" {
  name         = "dev-ChainLoopProjection"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "specimen_id"
  range_key    = "record_type"

  attribute {
    name = "specimen_id"
    type = "S"
  }

  attribute {
    name = "record_type"
    type = "S"
  }

  attribute {
    name = "current_status"
    type = "S"
  }

  attribute {
    name = "sla_due_at"
    type = "S"
  }

  global_secondary_index {
    name            = "status-sla-index"
    hash_key        = "current_status"
    range_key       = "sla_due_at"
    projection_type = "ALL"
  }
}