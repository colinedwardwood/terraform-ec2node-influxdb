resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "cew_influx_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "cew_working_public_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.default.id
 
 tags = {
   Name = "cew_influx_gw"
 }
}

resource "aws_route_table" "rt" {
 vpc_id = aws_vpc.default.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 
 tags = {
   Name = "cew_influx_igw_rt"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.public.id
 route_table_id = aws_route_table.rt.id
}