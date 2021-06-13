provider "aws" {
  region  = var.region
  profile = "default"
}

locals {
  availability_zones_l = [join("", [var.region, "a"]), join("", [var.region, "b"]), join("", [var.region, "c"])]
}

module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  tenancy              = var.tenancy
  name                 = var.name
  public_subnets_cidr  = var.public_subnet_cidr
  private_subnets_cidr = var.private_subnet_cidr
  availability_zones   = local.availability_zones_l
  key_name = var.key_name
  key_path = var.key_path
  webserver_ami_id = var.webserver_ami_id
  appserver_ami_id = var.appserver_ami_id
  appserver_instance_type = var.appserver_instance_type
  webserver_instance_type = var.webserver_instance_type 
}
