variable "module" {
  description = "The terraform module used to deploy"
  type        = string
}

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "github_secret_name" {
  type        = string
}

variable "docker_secret_name" {
  type = string
}

variable "snyk_secret_name" {
  description = "Snyk secret name"
  type = string
}

variable "environment" {
  type = string
}

variable "branch_name" {
  type = string
}
