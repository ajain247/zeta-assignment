output "vpc_id" {
  value = module.zeta_assignment.vpc_id
}

output "public_subnet_id" {
  value = module.zeta_assignment.public_subnet_id
}

output "private_subnet_id" {
  value = module.zeta_assignment.private_subnet_id
}

output "webserver_security_group_id" {
  value = module.zeta_assignment.webserver_security_group_id
}

output "appserver_security_group_id" {
  value = module.zeta_assignment.appserver_security_group_id
}

output "webservers_instance_id" {
  value = module.zeta_assignment.webservers_instance_id
}

output "appservers_instance_id" {
  value = module.zeta_assignment.appservers_instance_id
}
