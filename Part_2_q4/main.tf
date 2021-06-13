provider "aws" {
    region = var.region
    profile = "default"
}

locals{
    availability_zones_l = [join("",[var.region, a]), join("",[var.region, b], join("",[var.region, c]]
}

module "network" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    tenancy =   var.tenancy
    name = var.name
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    availability_zones = local.availability_zones_l
}