#Out put parameters for further use
output "public_ip" {
  value = "${join(",", aws_instance.web_server.*.public_ip)}"
}
