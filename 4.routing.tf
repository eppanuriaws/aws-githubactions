#Public Routing Table
resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "${var.vpc_name}-Public-Route-Table"
  }
}

#Private Routing Table
resource "aws_route_table" "terraform-private" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-Private-Route-Table"
  }
}

#Associating the routing tables with the Public subnets
resource "aws_route_table_association" "terraform-public" {
  #count          = 3
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.terraform-public.id
}

#Associating the routing tables with the Private subnets
resource "aws_route_table_association" "terraform-private" {
  #count          = 3
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index)
  route_table_id = aws_route_table.terraform-private.id
}