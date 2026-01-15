/// VPC ///

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    { "Name" = "vpc_homework" }
  )
}

/// Public subnets ///

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    { "Name" = "public_subnet_${count.index + 1}" }
  )
}


/// Private subnets ///

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    { "Name" = "private_subnet_${count.index + 1}" }
  )
}


/// Internet Gateway ///

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { "Name" = "Internet gateway" }
  )
}

/// Elastic IP - we can not launch NAT Gateway without an Elastic IP address ///

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}

/// NAT Gateway ///

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(
    var.tags,
    { "Name" = "NAT gateway" }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

/// Route tables ///

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

/// Public route table assosiation ///

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

/// Private route table assosiation ///

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
