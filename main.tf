resource "aws_vpc" "rockvpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "rockvpc"
  }
}

# creating public subnet 1
resource "aws_subnet" "prod-public-sub1" {
  vpc_id     = aws_vpc.rockvpc.id
  cidr_block = var.prod-public-sub1-cidr

  tags = {
    Name = "prod-public-sub1"
  }
}

# creating public subnet 2
resource "aws_subnet" "prod-public-sub2" {
  vpc_id     = aws_vpc.rockvpc.id
  cidr_block = var.prod-public-sub2-cidr

  tags = {
    Name = "prod-public-sub2"
  }
}

# creating public subnet 3
resource "aws_subnet" "prod-public-sub3" {
  vpc_id     = aws_vpc.rockvpc.id
  cidr_block = var.prod-public-sub3-cidr

  tags = {
    Name = "prod-public-sub3"
  }
}

# creating private subnet 1
resource "aws_subnet" "prod-priv-sub1" {
  vpc_id     = aws_vpc.rockvpc.id
  cidr_block = var.prod-priv-sub1-cidr

  tags = {
    Name = "prod-priv-sub1"
  }
}

# creating private subnet 2
resource "aws_subnet" "prod-priv-sub2" {
  vpc_id     = aws_vpc.rockvpc.id
  cidr_block = var.prod-priv-sub2-cidr

  tags = {
    Name = "prod-priv-sub2"
  }
}


# creating public route table 

resource "aws_route_table" "prod-pub-route-table" {
  vpc_id = aws_vpc.rockvpc.id


  tags = {
    Name = "prod-pub-route-table"
  }
}

# creating private route table 

resource "aws_route_table" "prod-priv-route-table" {
  vpc_id = aws_vpc.rockvpc.id
 route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.prod-natgaway.id
 }
  tags = {
    Name = "prod-priv-route-table"
  }
}

# route table association private subnet 1 with private route table 

resource "aws_route_table_association" "prod-priv-sub1-Association" {

  subnet_id      = aws_subnet.prod-priv-sub1.id
  route_table_id = aws_route_table.prod-priv-route-table.id
}


# route table association private subnet 2 with private route table 

resource "aws_route_table_association" "prod-priv-sub2-Association" {

  subnet_id      = aws_subnet.prod-priv-sub2.id
  route_table_id = aws_route_table.prod-priv-route-table.id

}

# route table association public subnet 1 with private route table 

resource "aws_route_table_association" "prod-public-sub1-Association" {

  subnet_id      = aws_subnet.prod-public-sub1.id
  route_table_id = aws_route_table.prod-pub-route-table.id

}

# route table association public subnet 2 with private route table 

resource "aws_route_table_association" "prod-public-sub2-Association" {

  subnet_id      = aws_subnet.prod-public-sub2.id
  route_table_id = aws_route_table.prod-pub-route-table.id

}

# route table association public subnet 3 with private route table 

resource "aws_route_table_association" "prod-public-sub3-Association" {

  subnet_id    = aws_subnet.prod-public-sub3.id
  route_table_id = aws_route_table.prod-pub-route-table.id

}
# internet gateway

resource "aws_internet_gateway" "prod-IGW" {
  vpc_id = aws_vpc.rockvpc.id

  tags = {
    Name = "prod-IGW"
  }
}

#IGW association with public route table

resource "aws_route" "rock-IGW-association" {
  route_table_id         = aws_route_table.prod-pub-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.prod-IGW.id
}

# Elastic IP
resource "aws_eip" "ip_natgateway" {
vpc = true

}
resource "aws_nat_gateway" "prod-natgaway" {
  allocation_id = aws_eip.ip_natgateway.id
  subnet_id     = aws_subnet.prod-public-sub3.id

  }


 