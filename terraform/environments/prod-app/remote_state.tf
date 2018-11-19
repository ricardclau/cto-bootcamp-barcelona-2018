terraform {
  backend "s3" {
    bucket         = "cto-bcn18-${var.project}-devops-terraform"
    key            = "${var.environment_name}-app/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "${var.project}-terraform-state-lock"
  }
}
