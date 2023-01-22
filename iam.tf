resource "aws_iam_user" "me" {
  name = "danadajian"
}

resource "aws_iam_user_policy_attachment" "admin" {
  user       = aws_iam_user.me.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "my_key" {
  user = aws_iam_user.me.name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret" "key" {
  name = "aws_access_key_id"
}

resource "aws_secretsmanager_secret_version" "id" {
  secret_id     = aws_secretsmanager_secret.key.id
  secret_string = aws_iam_access_key.my_key.id
}

resource "aws_secretsmanager_secret" "secret" {
  name = "aws_secret_access_key"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = aws_iam_access_key.my_key.secret
}
