variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tenancy" {
  type    = string
  default = "default"
}

variable "name" {
  type    = string
  default = "zeta-assignment"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  type    = list(any)
  default = ["10.0.2.0/24"]
}

variable "key_name" {
  type    = string
  default = "ec2-key-pair"
}

variable "key_path" {
  type    = string
  default = "/home/cloud_user/.ssh/id_rsa.pub"
}

variable "webserver_ami_id" {
  type    = string
  default = "ami-0aeeebd8d2ab47354"
}

variable "appserver_ami_id" {
  type    = string
  default = "ami-0aeeebd8d2ab47354"
}

variable "appserver_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "webserver_instance_type" {
  type    = string
  default = "t2.micro"
}

