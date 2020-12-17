variable "name" {
  description = "The name of the Build"
  type        = string
}

variable "environment" {
  type = string
}

variable "docker_id" {
  type = string
}

variable "docker_pw" {
  type = string
}

variable "image" {
  description = "CodeBuild Container base image"
  type = string
}

variable "snyk_auth_token" {
  description = "Snyk authentication token"
  type = string
}