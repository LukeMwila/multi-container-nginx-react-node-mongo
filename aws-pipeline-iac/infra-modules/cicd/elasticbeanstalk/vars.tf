variable "name" {
  description = "Name of the eb application"
  type = string
}

variable "description" {
  description = "Description of the eb application"
  type = string
}

variable "solution_stack_name" {
  description = "The name of thhe solution stack for the platform"
  type = string
}

variable "environment" {
  type = string
}

variable "tier" {
  description = "Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used."
  default = "WebServer"
  type = string
}
