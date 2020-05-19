# IAM role
resource "aws_iam_role" "main" {
  name = "${var.name}-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.main.json
}

# This is a data source which can be used to construct a 
# JSON representation of an IAM policy document, 
# for use with resources which expect policy documents, 
# such as the aws_iam_policy resource.

data "aws_iam_policy_document" "main" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  } 
}

# Policies for different environments

resource "aws_iam_policy" "main" {
  name = "${var.name}-policy-${var.environment}"
  description = "Allow AWS Codepipeline deployments for Multicontainer application"
  policy = data.aws_iam_policy_document.codepipeline_mutlicontainer_app.json
}

resource "aws_iam_role_policy_attachment" "mutlicontainer_app" {
  role = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

data "aws_iam_policy_document" "codepipeline_mutlicontainer_app" {
    statement {
        effect = "Allow"

        actions = [
          "s3:*",
        ]

        resources = [
          "arn:aws:s3:::*"
        ]
    }

    statement {
        effect = "Allow"

        actions = [
          "codebuild:StartBuild",
          "codebuild:StopBuild",
          "codebuild:BatchGetBuilds",
          "codebuild:UpdateReportGroup",
          "codebuild:ListReportsForReportGroup",
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:ListReports",
          "codebuild:DeleteReport",
          "codebuild:ListReportGroups",
          "codebuild:BatchPutTestCases"
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "cloudformation:CreateStack",
          "cloudformation:UpdateStacks",
          "cloudformation:DeleteStacks",
          "cloudformation:DescribeStacks",
          "cloudformation:DescribeStackEvents",
          "cloudformation:DescribeStackResource",
          "cloudformation:DescribeStackResources",
          "cloudformation:GetTemplate",
          "cloudformation:ValidateTemplate",
          "cloudformation:UpdateStack",
          "cloudformation:CancelUpdateStack" 
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "elasticbeanstalk:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "ecs:*"
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "devicefarm:ListProjects",
          "devicefarm:ListDevicePools",
          "devicefarm:GetRun",
          "devicefarm:GetUpload",
          "devicefarm:CreateUpload",
          "devicefarm:ScheduleRun"
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "opsworks:CreateDeployment",
          "opsworks:DescribeApps",
          "opsworks:DescribeCommands",
          "opsworks:DescribeDeployments",
          "opsworks:DescribeInstances",
          "opsworks:DescribeStacks",
          "opsworks:UpdateApp",
          "opsworks:UpdateStack"
        ]

        resources = ["*"]
    }

    statement {
        effect = "Allow"

        actions = [
          "servicecatalog:ListProvisioningArtifacts",
          "servicecatalog:CreateProvisioningArtifact",
          "servicecatalog:DescribeProvisioningArtifact",
          "servicecatalog:DeleteProvisioningArtifact",
          "servicecatalog:UpdateProduct"
        ]

        resources = ["*"]
    }
}





