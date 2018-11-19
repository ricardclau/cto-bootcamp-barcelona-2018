data "aws_security_group" "bastion" {
  name = "bastion-${var.project}-${var.environment_name}"
}

resource "aws_security_group" "app" {
  name        = "app-${var.environment_name}"
  description = "For app-${var.environment_name} instances"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags {
    Name = "app-${var.environment_name}"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app_elb.id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${data.aws_security_group.bastion.id}"]
  }

  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["${data.aws_vpc.main.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_elb" {
  name        = "app-${var.environment_name}-elb"
  description = "For app-${var.environment_name} ELB"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags {
    Name = "app-${var.environment_name}-elb"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["${data.aws_vpc.main.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
