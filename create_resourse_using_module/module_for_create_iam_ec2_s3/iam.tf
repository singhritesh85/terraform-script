resource "aws_iam_policy" "s3_full_access" {
  name        = var.policy_name
  path        = "/"
  description = "S3-Full-Access"

  policy = file("/root/create_resourse_using_module/module_for_create_iam_ec2_s3/policy.json")
}

resource "aws_iam_role" "Role_s3_Access_Full" {
  name = var.role_name
  assume_role_policy = "${file("/root/create_resourse_using_module/module_for_create_iam_ec2_s3/trust-relationship.json")}"

  tags = {
    Name = "mytag"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.Role_s3_Access_Full.name
  depends_on = [ aws_iam_policy.s3_full_access, aws_iam_role.Role_s3_Access_Full ]
}

resource "aws_iam_role_policy_attachment" "ec2_iam_attach" {
  role       = aws_iam_role.Role_s3_Access_Full.name
  policy_arn = aws_iam_policy.s3_full_access.arn
  depends_on = [ aws_iam_policy.s3_full_access, aws_iam_role.Role_s3_Access_Full ]
}
