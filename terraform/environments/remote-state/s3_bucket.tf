resource "aws_s3_bucket" "terraform_remote_state" {
  bucket = "cto-bcn18-${var.project}-devops-terraform"
  acl    = "private"

  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name = "cto-bcn18-${var.project}-devops-terraform"
  }
}
