variable "ami_id"{
    type=string
}

variable "instance_type" {
    type=string
    default = "t2.micro"
}

variable "subnet_id"{
    type=string
}

variable "associate_public_ip_address"{
    type=string
}