#out put variables needed in further steps(if any)
output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "web_server_security_group" {
  value = "${aws_security_group.web_server_sec_group.id}"
}
