resource "aws_elastic_beanstalk_application" "main" {
  name        = var.name
  description = var.description
}

resource "aws_elastic_beanstalk_environment" "main" {
  name                = "eb-${var.environment}"
  application         = "${aws_elastic_beanstalk_application.main.name}"
  solution_stack_name = var.solution_stack_name
  tier = var.tier
}