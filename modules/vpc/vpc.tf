#Define vpc
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.4.0.0/24"

  tags {
    Name = "${var.name}"
  }
}

#Public subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = "10.4.0.0/28"
  vpc_id     = "${aws_vpc.test_vpc.id}"

  tags {
    Name = "${var.name}-subnet"
  }
}

# Internet gateway to route traffic outside
resource "aws_internet_gateway" "test_igw" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  tags {
    Name = "${var.name}-igw"
  }
}

#Route table for vpc
resource "aws_route_table" "test_routes" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test_igw.id}"
  }

  tags {
    Name = "${var.name}-route-table"
  }
}

#Associate routes to subnets
resource "aws_route_table_association" "test_route_assoc" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.test_routes.id}"
}

#security groups for web server ( only ssh and http traffic allowed from outside)
resource "aws_security_group" "web_server_sec_group" {
  name        = "web_server_security_group"
  description = "security group for web server"

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.test_vpc.id}"
}
