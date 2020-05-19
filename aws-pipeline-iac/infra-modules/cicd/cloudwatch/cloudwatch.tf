resource "aws_cloudwatch_event_rule" "main" {
  name = "${var.name}-${var.environment}"
  description = var.description

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codepipeline"
  ],
  "detail-type": [
    "CodePipeline Pipeline Execution State Change"
  ],
  "resources": [
    "${var.codepipeline_arn}"
  ],
  "detail": {
    "pipeline": [
      "${var.codepipeline_name}"
    ],
    "state": [
      "RESUMED",
      "FAILED",
      "CANCELED",
      "SUCCEEDED",
      "SUPERSEDED",
      "STARTED"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "main" {
  rule      = aws_cloudwatch_event_rule.main.name
  target_id = var.targetId
  arn       = var.resource_arn
  input_transformer {
    input_template = <<DOC
{
  "pipeline": <pipeline>,
  "state": <state>
}
  DOC
    input_paths = {
      pipeline: "$.detail.pipeline",
      state: "$.detail.state"
    }
  }
}