resource "aws_subnet" "public" {
  count = "${var.azs}"

  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(null_resource.network_layer_cidrs.triggers.dmz, 2, count.index)}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.project}-${var.environment_name}-Public-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.project}-${var.environment_name}-PublicRouteTable-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table_association" "public" {
  count = "${var.azs}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}
