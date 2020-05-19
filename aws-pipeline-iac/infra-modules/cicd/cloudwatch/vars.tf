variable name {
  description = "The name of the CloudWatch event rule"
  type = string
}

variable description {
  description = "CloudWatch event description"
  type = string
}

variable targetId {
  type = string
}

variable resource_arn {
  description = "The ARN for the target resource"
  type = string
}

variable role_name {
  description = "The name of the iam role for the cloudwatch event"
  type = string
}

variable policy_name {
  description = "The name of the iam role for the cloudwatch event"
  type = string
}

variable codepipeline_arn {
  description = "The ARN for the CodePipeline resource"
  type = string
}

variable codepipeline_name {
  description = "The name of the CodePipeline resource"
  type = string
}

variable "environment" {
  type = string
}
