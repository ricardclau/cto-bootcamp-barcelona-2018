module "app" {
  source = "../../modules/apache-app"

  environment_name = "${var.environment_name}"
  region           = "${var.region}"
  project          = "${var.project}"
  key_name         = "${var.key_name}"
}
