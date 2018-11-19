resource "aws_iam_instance_profile" "app" {
  name = "app-${var.project}-${var.environment_name}"
  role = "${aws_iam_role.app.name}"
}

data "aws_iam_policy_document" "iam_for_ec2_policy_document" {
  "statement" {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app" {
  name               = "app-${var.project}-${var.environment_name}"
  assume_role_policy = "${data.aws_iam_policy_document.iam_for_ec2_policy_document.json}"
}

data "aws_iam_policy_document" "s3secrets_assume_role_policy" {
  "statement" {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::app-secrets",
      "arn:aws:s3:::app-secrets/*",
    ]
  }
}

resource "aws_iam_role_policy" "s3_secrets_read" {
  name   = "s3_secrets_read"
  role   = "${aws_iam_role.app.id}"
  policy = "${data.aws_iam_policy_document.s3secrets_assume_role_policy.json}"
}
