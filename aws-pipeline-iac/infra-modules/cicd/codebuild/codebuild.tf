resource "aws_codebuild_project" "main" {
  name = "${var.name}-${var.environment}"
  service_role = aws_iam_role.main.arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }

  #cache {
  #  type = "S3"
  #  location = "${var.bucket_name}/${var.name}/build_cache"
  #}

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "STAGE_NAME"
      value = var.environment
    }

    environment_variable {
      name  = "DOCKER_ID"
      value = var.docker_id
    }

    environment_variable {
      name  = "DOCKER_PW"
      value = var.docker_pw
    }

    environment_variable {
      name  = "SNYK_AUTH_TOKEN"
      value = var.snyk_auth_token
    } 
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
