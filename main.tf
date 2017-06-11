#Main template to start execution of stack

#AWS user access credentials
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

#Call module vpc to create vpc
module "test_vpc" {
  source = "./modules/vpc"
  name   = "test_vpc"
}

#Call module ec2 to create web server
module "web_server" {
  source          = "./modules/ec2"
  name            = "web-server"
  security_groups = ["${module.test_vpc.web_server_security_group}"]
  subnet_id       = "${module.test_vpc.public_subnet_id}"
  keypair_name    = "${var.keypair_name}"
  instance_type   = "${var.instance_type}"

  user_data = "${var.user_data}"
}

#User data to Bootstrapthe web server
data "template_file" "agent-userdata" {
  template = "${file("data/user-data")}"

  vars {
    server_ip_address = "${element(split(",", module.web_server.public_ip), 0)}"
  }
}

#To configure the web server by executing the startup user-data script
resource "null_resource" "configure_web_host" {
  count = "${var.count}"

  connection {
    type        = "ssh"
    agent       = false
    user        = "ec2-user"
    host        = "${element(split(",", module.web_server.public_ip), count.index)}"
    private_key = "${file("${var.key_file}")}"
  }

  provisioner "remote-exec" {
    inline = ["${data.template_file.agent-userdata.rendered}"]
  }

}
