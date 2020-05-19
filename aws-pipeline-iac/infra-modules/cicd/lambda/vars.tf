variable function_name {
  description = "The function name"
  type = string
}

variable handler {
  description = "The handler name"
  type = string
  default = "index.handler"
}

variable runtime {
  description = "The runtime environment for the lambda function"
  type = string
  default = "nodejs12.x"
}

variable source_arn {
  description = "The ARN of the resource that triggers the lambda function"
  type = string
}

variable lambda_role {
  description = "The name of the iam role"
  type = string
}

variable lambda_policy {
  description = "The name of the policy"
  type = string
}

variable "environment" {
  type = string
}