resource "aws_iam_role" "main" {
  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudwatch.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main" {
  name = var.policy_name
  role = aws_iam_role.main.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "lambda:*"
      ],
      "Resource": "${var.resource_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codepipeline:*"
      ],
      "Resource": "${var.codepipeline_arn}"
    }
  ]
}
EOF
}

