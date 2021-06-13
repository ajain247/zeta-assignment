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

