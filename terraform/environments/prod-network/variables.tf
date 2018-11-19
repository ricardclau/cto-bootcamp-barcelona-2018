variable "key_name" {
  default = "Put your key pair name here"
}

variable "project" {
  default = "Put your name here"
}

variable "environment_name" {
  default = "prod"
}

variable "vpc_network" {
  default     = "Put your assigned CIDR here"
  description = "Something like 10.162.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "azs" {
  default = 3
}

variable "office_ip_cidrs" {
  type    = "list"
  default = ["0.0.0.0/0"]
}
