variable "key_name"{
    type=string
}

variable "key_path"{
    type=string
}

variable "webserver_ami_id"{
    type=string
}

variable "appserver_ami_id"{
    type=string
}

variable "appserver_instance_type" {
    type=string
}

variable "webserver_instance_type" {
    type=string
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for the public subnets"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for the private subnets"
}
