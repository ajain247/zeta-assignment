resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = var.tenancy
    enable_dns_support= true
    enable_dns_hostnames= true

    tags = {
        Name = join("-",[var.name,"vpc"])
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    count = length(var.public_subnet_cidr)
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = { 
        Name = join("-", [var.name, element(var.availabilty_zones, count.index), public-subnet ])

    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr, count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = join("-", [var.name, element(var.availabilty_zones, count.index), private-subnet ])
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = Name = join("-",[var.name,"igw"])
    }
}

resource "aws_eip" "elastic_ip_nat" {
    vpc = true
    depends_on = [aws_internet_gateway.igw]

}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.elastic_ip_nat.subnet_id
    subnet_id = element(aws_subnet.public_subnet.*.id, 0)
    depends_on = [aws_internet_gateway.igw]
    tags = {
        Name = join("-", [var.name , "nat"])
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = join("-", [var.name , "public-route-table"])
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = join("-", [var.name , "private-route-table"])
    }
}

resource "aws_route" "igw_public" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_private" {
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id

}

resource "aws_route_table_association" "public_rt_association"{
    count = length(var.public_subnet_cidr)
    subnet_id = element(aws_subnet.public_subnet.id, count.index)
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association"{
    count = length(var.private_subnet_cidr)
    subnet_id = element(aws_subnet.private_subnet.id, count.index)
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "default_sg" {
    vpc_id = aws_vpc.vpc.id
    name = join("-", [var.name,"default-sg"])
    description = "Default security group to allow traffic from VPC"
    ingress{
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        self = true
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        self = true
    }

}
