# Public subnet 1
resource "aws_subnet" "public-subnet1" {
  vpc_id            = aws_vpc.Prod-vpc.id
  cidr_block        = var.cidr-for-pubsub1
  availability_zone = var.AZ-1

  tags = {
    Name = "public-subnet1"
  }
}


# Public subnet 2
resource "aws_subnet" "public-subnet2" {
  vpc_id            = aws_vpc.Prod-vpc.id
  cidr_block        = var.cidr-for-pubsub2
  availability_zone = var.AZ-2

  tags = {
    Name = "public-subnet2"
  }
}


# Private subnet 1
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.Prod-vpc.id
  cidr_block        = var.cidr-for-privsub1
  availability_zone = var.AZ-3

  tags = {
    Name = "private-subnet1"
  }
}


# Private subnet 2
resource "aws_subnet" "private-subnet2" {
  vpc_id            = aws_vpc.Prod-vpc.id
  cidr_block        = var.cidr-for-privsub2
  availability_zone = var.AZ-3

  tags = {
    Name = "private-subnet2"
  }
}


# Public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.Prod-vpc.id

  tags = {
    Name = "public-route-table"
  }
}


# Private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.Prod-vpc.id

  tags = {
    Name = "private-route-table"
  }
}


# Public route table associations
resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-table-association2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-route-table.id
}


# Private route table association
resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-route-table-association2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-route-table.id
}


# Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Prod-vpc.id

  tags = {
    Name = "IGW"
  }
}


# AWS Route IGW-Public route table
resource "aws_route" "public-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.IGW.id
  destination_cidr_block = var.public_route_destination_cidr_block
}
