resource "aws_codepipeline" "main" {
    name = "${var.name}-${var.environment}"
    role_arn = aws_iam_role.main.arn

    artifact_store {
        location = "${aws_s3_bucket.main.bucket}"
        type = "S3"
    }

    stage {
        name = "Source"
        action {
            name             = "Source"
            category         = "Source"
            owner            = "ThirdParty"
            provider         = "GitHub"
            version          = "1"
            output_artifacts = ["SourceArtifact"]

            configuration = {
                Owner                = var.github_org
                Repo                 = var.repository_name
                PollForSourceChanges = "true"
                Branch               = var.branch_name
                OAuthToken           = var.github_token
            }
        }
    }

    stage {
        name = "Build"

        action {
            name = "Build"
            category = "Build"
            owner = "AWS"
            provider = "CodeBuild"
            input_artifacts = ["SourceArtifact"]
            output_artifacts = ["BuildArtifact"]
            version = "1"

            configuration = {
                ProjectName   = var.project_name
                PrimarySource = "SourceArtifact"
            }
            run_order = 2
        }
    }
}