provider {
    region = var.region
}

resource "aws_vpc" "AD-vpc1" {
  cidr = var.cidr_block_vpc1

  enable_dns_hostnames = true

  tags = {
    "Name" = var.VPC1
  }

}

resource "aws_vpc" "AD-vpc2" {
  cidr = var.cidr_block_vpc2

  enable_dns_hostnames = true

  tags = {
    "Name" = var.VPC2
  }

}

resource "aws_subnet" "AD-vpc1pub-subnet" {
  vpc_id                  = aws_vpc.AD-vpc1.id
  cidr_block              = element(var.pubsubnets, 0)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, 0)

  tags = {
    Name = "VPC-AD-MS-Public-Subnet"
  }

}

resource "aws_subnet" "AD-vpc1priv-subnet" {
  vpc_id                  = aws_vpc.AD-vpc1.id
  cidr_block              = element(var.privsubnets, 0)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, 1)

  tags = {
    Name = "VPC-AD-MS-Priv-Subnet"
  }

}

resource "aws_subnet" "AD-vpc2pub-subnet" {
  vpc_id                  = aws_vpc.AD-vpc2.id
  cidr_block              = element(var.pubsubnets, 1)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, 0)

  tags = {
    Name = "VPC-ONPREM-Public-Subnet"
  }

}

resource "aws_subnet" "AD-vpc2priv-subnet" {
  vpc_id                  = aws_vpc.AD-vpc2.id
  cidr_block              = element(var.privsubnets, 1)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, 1)

  tags = {
    Name = "VPC-ONPREM-Priv-Subnet"
  }

}

resource "aws_internet_gateway" "VPC1-IGW" {
  vpc_id = aws_vpc.AD-vpc1.id

  tags = {
    Name = "VPC-AD-MS-IGW"
  }
}

resource "aws_internet_gateway" "VPC2-IGW" {
  vpc_id = aws_vpc.AD-vpc2.id

  tags = {
    Name = "VPC-ONPREM-IGW"
  }
}

resource "aws_vpc_peering_connection" "VPC-peer" {
  peer_vpc_id   = aws_vpc.AD-vpc2.id
  vpc_id        = aws_vpc.AD-vpc1.id
  auto_accept   = true

  tags = {
    Name = "VPC-Peering-VPC-AD-MS-&-VPC-ONPREM"
  }
}

resource "aws_route_table" "AD-vpc1-route1" {
  vpc_id        = aws_vpc.AD-vpc1.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.VPC1-IGW.id
  }

  tags = {
    Name = "VPC-AD-MS-ROUTE1"
  }
}

resource "aws_route_table" "AD-vpc1-route2" {
  vpc_id        = aws_vpc.AD-vpc1.id
  depends_on    = aws_vpc_peering_connection.VPC-peer.id
  route {
    cidr_block  = var.cidr_block_vpc2
    vpc_peering_connection_id  = aws_vpc_peering_connection.VPC-peer.id
  }

  tags = {
    Name = "VPC-AD-MS-ROUTE2"
  }
}

resource "aws_route_table" "AD-vpc2-route1" {
  vpc_id        = aws_vpc.AD-vpc2.id
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.VPC2-IGW.id
  }

  tags = {
    Name = "VPC-ONPREM-ROUTE1"
  }
}

resource "aws_route_table" "AD-vpc2-route2" {
  vpc_id        = aws_vpc.AD-vpc2.id
  depends_on    = aws_vpc_peering_connection.VPC-peer.id
  route {
    cidr_block  = var.cidr_block_vpc1
    vpc_peering_connection_id  = aws_vpc_peering_connection.VPC-peer.id
  }

  tags = {
    Name = "VPC-ONPREM-ROUTE2"
  }
}

resource "aws_route_table_association" "public-association-vpc1" {
  route_table_id = aws_route_table.AD-vpc1-route1.id
  subnet_id      = aws_subnet.AD-vpc1pub-subnet.id
}

resource "aws_route_table_association" "private-association-vpc1" {
  route_table_id = aws_route_table.AD-vpc1-route2.id
  subnet_id      = aws_subnet.AD-vpc1priv-subnet.id
}

resource "aws_route_table_association" "public-association-vpc2" {
  route_table_id = aws_route_table.AD-vpc2-route1.id
  subnet_id      = aws_subnet.AD-vpc2pub-subnet.id
}

resource "aws_route_table_association" "private-association-vpc2" {
  route_table_id = aws_route_table.AD-vpc2-route2.id
  subnet_id      = aws_subnet.AD-vpc2priv-subnet.id
}



