resource "aws_iam_role_policy" "iam_policy" {
  name = var.iam_policy_name
  role = aws_iam_role.iam_role.id

  policy = file("policy.json")
  depends_on = [ aws_iam_role.iam_role ]
}

resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name

  assume_role_policy = file("trusted-advisor.json")
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = var.iam_profile_name
  role = aws_iam_role.iam_role.name
}
