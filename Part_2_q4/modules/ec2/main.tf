resource "aws_key_pair" "key_pair"{
    key_name = var.key_name
    public_key= file(var.key_path)

}

resource "aws_instance" "webserever" {
    count = length(var.public_subnets_cidr)
    ami = var.webserver_ami_id
    key_name = aws_key_pair.key_pair.id
    instance_type = var.webserver_instance_type
    subnet_id = element(module.network.public_subnet_id, 0)
    vpc_security_group_ids= module.network.default_security_group_id
} 

resource "aws_instance" "appserver" {
    count = length(var.private_subnets_cidr)
    ami = var.appserver_ami_id
    key_name = aws_key_pair.key_pair.id
    instance_type = var.appserver_instance_type
    subnet_id = element(module.network.private_subnet_id, 0)
    vpc_security_group_ids= [module.network.default_security_group_id]
}