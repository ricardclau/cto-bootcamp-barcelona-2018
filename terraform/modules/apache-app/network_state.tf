data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-${var.environment_name}"]
  }
}

data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Name = "${var.project}-${var.environment_name}-Private*"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.main.id}"

  tags {
    Name = "${var.project}-${var.environment_name}-Public*"
  }
}
