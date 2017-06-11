#All the variables requuired in ec2 module
variable "name" {}

variable "user_data" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_groups" {
  default = []
}

variable "subnet_id" {}

variable "instance_count" {
  default = 1
}

variable "keypair_name" {
  default = "test-keypair"
}
