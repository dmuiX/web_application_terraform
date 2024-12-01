resource "aws_iam_role" "web_app_role" {
  name = var.web_app_iam_user
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "web_app_policy" {
  name        = "web_app_policy"
  description = "Policy for web app role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:*",
          "ec2:*",
          "iam:CreateUser",
          "iam:DeleteUser",
          "iam:ListUsers",
          "iam:GetUser",
          "iam:UpdateUser",
          "iam:UpdateAccessKey",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:ListPolicies",
          "iam:GetPolicy",
          "iam:UpdatePolicy",
          "s3:*",
          "dynamodb:*",
          "route53:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "web_app_role_policy_attachment" {
  role       = aws_iam_role.web_app_role.name
  policy_arn = aws_iam_policy.web_app_policy.arn
}
resource "aws_iam_instance_profile" "web_app_instance_profile" {
  name = var.web_app_instance_profile
  role = aws_iam_role.web_app_role.name
}