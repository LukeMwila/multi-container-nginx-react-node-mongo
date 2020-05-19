output application_arn {
  value = aws_elastic_beanstalk_application.main.arn
}

output application_name {
  value = aws_elastic_beanstalk_application.main.name
}

output environment_arn {
  value = aws_elastic_beanstalk_environment.main.arn
}

output environment_name {
  value = aws_elastic_beanstalk_environment.main.name
}