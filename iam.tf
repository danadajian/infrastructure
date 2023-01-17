resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-iam-role"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.default.arn
        }
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:danadajian/*"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          }
        }
      },
    ]
  })
}
