variable "name" {
  description = "Name of pipeline"
  type = string
}

variable "repository_name" {
  description = "Name of repository"
  type = string
}

variable "project_name" {
  description = "Name of CodeBuild project"
  type = string
}

#variable elasticbeanstalk_application_name {
#  description = "Name of ElasticBeanstalk application"
#  type = string
#}

#variable elasticbeanstalk_application_environment_name {
#  description = "Name of ElasticBeanstalk application environment"
#  type = string
#}

variable "bucket_name" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "region" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_token" {
  description = "Name of github token"
  type = string
}

variable "environment" {
  type = string
}
