# GitHub secrets
data "aws_secretsmanager_secret" "github_secret" {
  name = var.github_secret_name
}

data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = data.aws_secretsmanager_secret.github_secret.id
}

# Docker secrets
data "aws_secretsmanager_secret" "docker_secret" {
  name = var.docker_secret_name
}

data "aws_secretsmanager_secret_version" "docker_creds" {
  secret_id = data.aws_secretsmanager_secret.docker_secret.id
}

# Snyk secrets
data "aws_secretsmanager_secret" "snyk_secret" {
  name = var.snyk_secret_name
}

data "aws_secretsmanager_secret_version" "snyk_auth" {
  secret_id = data.aws_secretsmanager_secret.snyk_secret.id
}

# Elastic Beanstalk solution stack
data "aws_elastic_beanstalk_solution_stack" "multi_docker" {
  most_recent = true

  name_regex = "^64bit Amazon Linux (.*) Multi-container Docker (.*)$"
}

# Codebuild module for CI
module "codebuild_for_multicontainer_app" {
  source = "./codebuild"
  name = "codebuild-multicontainer-docker-app"
  image       = "aws/codebuild/standard:4.0"
  docker_id = jsondecode(data.aws_secretsmanager_secret_version.docker_creds.secret_string)["DOCKER_ID"]
  docker_pw = jsondecode(data.aws_secretsmanager_secret_version.docker_creds.secret_string)["DOCKER_PW"]
  snyk_auth_token = jsondecode(data.aws_secretsmanager_secret_version.snyk_auth.secret_string)["SNYK_AUTH_TOKEN"]
  environment     = var.environment
}

# CodePipeline module for CICD pipeline
module "codepipeline_for_multicontainer_app" {
  source = "./codepipeline"
  name = "codepipeline-multicontainer-docker-app"
  bucket_name = "codepipeline-multicontainer-docker-app-artifact"
  github_org = "LukeMwila"
  repository_name = "multi-container-nginx-react-node-mongo"
  branch_name = var.branch_name
  environment     = var.environment
  region = var.region
  #elasticbeanstalk_application_name = module.elasticbeanstalk_for_multicontainer_app.application_name
  #elasticbeanstalk_application_environment_name = module.elasticbeanstalk_for_multicontainer_app.environment_name
  project_name = module.codebuild_for_multicontainer_app.project_name
  github_token = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
}

# Elastic Beanstalk module for multicontainer app
#module "elasticbeanstalk_for_multicontainer_app" {
#  source = "./elasticbeanstalk"
#  name = "multicontainer-nginx-react-node-mongo-app"
#  description = "Docker multicontainer application consisting of an Nginx web server, React client and a NodeJS backend."
#  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.multi_docker.name
#  tier = "WebServer"
#  environment = var.environment
#}

# Cloudwatch event module for pipeline state changes
module "cloudwatch_for_pipeline_notifications" {
  source = "./cloudwatch"
  name = "multicontainer-pipeline-state-change"
  description = "event for multicontainer app pipeline state change"
  role_name = "cloudwatch-for-multicontainer-pipeline-role"
  policy_name = "cloudwatch-for-multicontainer-pipeline-policy"
  targetId = "SendToLambda"
  codepipeline_arn = module.codepipeline_for_multicontainer_app.arn
  codepipeline_name = module.codepipeline_for_multicontainer_app.name
  resource_arn = module.lambda_for_pipeline_notifications.arn
  environment = var.environment
}

# Lambda module for pushing pipeline state change notifications to Slack
module "lambda_for_pipeline_notifications" {
  source = "./lambda"
  function_name = "lambda-push-pipeline-notification-to-slack"
  source_arn = module.cloudwatch_for_pipeline_notifications.arn
  lambda_role = "lambda-for-multicontainer-pipeline-role"
  lambda_policy = "lambda-for-multicontainer-pipeline-policy"
  environment = var.environment
}