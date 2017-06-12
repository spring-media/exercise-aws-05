#variable defination for main.tf 
variable "region" {
  default = "eu-west-1"
}

variable "count" {
  default = 1
}

variable "key_file" {
  default = "test-key.pem"
}

variable "keypair_name" {}

variable "instance_type" {}

variable "user_data" {
default = "data/user-data"
}

variable "aws_access_key" {
  default = ""
  description = "the user aws access key"
}

variable "aws_secret_key" {
  default = ""
  description = "the user aws secret key"
}
