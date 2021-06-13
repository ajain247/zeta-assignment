resource "aws_instance" "webserever" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    associate_public_ip_address = var.associate_public_ip_address
}