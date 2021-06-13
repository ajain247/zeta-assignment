resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = join("-", [var.name, "vpc"])
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", [var.name, element(var.availability_zones, count.index), "public-subnet"])

  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = join("-", [var.name, element(var.availability_zones, count.index), "private-subnet"])
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [var.name, "igw"])
  }
}

resource "aws_eip" "elastic_ip_nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip_nat.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = join("-", [var.name, "nat"])
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [var.name, "public-route-table"])
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [var.name, "private-route-table"])
  }
}

resource "aws_route" "igw_public" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "nat_private" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gw.id

}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "default_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = join("-", [var.name, "default-sg"])
  description = "Default security group to allow traffic from VPC"
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

}

resource "aws_key_pair" "key_pair"{
    key_name = var.key_name
    public_key= file(var.key_path)

}

resource "aws_instance" "webserver" {
    count = length(var.public_subnets_cidr)
    ami = var.webserver_ami_id
    key_name = aws_key_pair.key_pair.id
    instance_type = var.webserver_instance_type
    subnet_id = element(aws_subnet.public_subnet.*.id,count.index)
    vpc_security_group_ids= [aws_security_group.default_sg.id]

    tags = {
      Name = join("-",["webserver",count.index])
    }
} 

resource "aws_instance" "appserver" {
    count = length(var.private_subnets_cidr)
    ami = var.appserver_ami_id
    key_name = aws_key_pair.key_pair.id
    instance_type = var.appserver_instance_type
    subnet_id = element(aws_subnet.private_subnet.*.id,count.index)
    vpc_security_group_ids= [aws_security_group.default_sg.id]

    tags = {
      Name = join("-",["appserver",count.index])
    }
}