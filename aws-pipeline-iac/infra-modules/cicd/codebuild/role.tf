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
      identifiers = ["codebuild.amazonaws.com"]
    }
  } 
}

# Policies for select environment

resource "aws_iam_policy" "main" {
    name = "${var.name}-policy-${var.environment}"
    description = "Allow AWS CodeBuild builds for Multicontainer application"
    policy = data.aws_iam_policy_document.codebuild_multicontainer_app.json
}

resource "aws_iam_role_policy_attachment" "mutlicontainer_app" {
  role = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

data "aws_iam_policy_document" "codebuild_multicontainer_app" {
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

    resources = [
      "arn:aws:codebuild:eu-west-1:*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:CreateBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue"
    ]

    resources = [
      "arn:aws:secretsmanager:eu-west-1:*"
    ]
  }
} 
