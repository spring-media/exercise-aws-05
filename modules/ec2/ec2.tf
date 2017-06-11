#Define emi
data "aws_ami" "aws_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Amazon-Linux-64bit-HVM-10-31-16"]
  }
  owners = ["531700196402"]
}

#Define the required ec2 web server

resource "aws_instance" "web_server" {
  count                       = "${var.instance_count}"
  ami                         = "${data.aws_ami.aws_linux.id}"
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = ["${var.security_groups}"]
  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = true
  key_name                    = "${var.keypair_name}"
  user_data                   = "${var.user_data}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags {
    Name = "${var.name}-${count.index + 1}"
  }


}
