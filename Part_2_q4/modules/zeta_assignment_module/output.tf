output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = [aws_subnet.public_subnet.*.id]
}

output "private_subnet_id" {
  value = [aws_subnet.private_subnet.*.id]
}

output "webserver_security_group_id" {
  value = aws_security_group.webserver_sg.id
}

output "appserver_security_group_id" {
  value = aws_security_group.appserver_sg.id
}

output "webservers_instance_id" {
  value =[aws_instance.webserver.*.id]
}

output "appservers_instance_id" {
  value =[aws_instance.appserver.*.id]
}
