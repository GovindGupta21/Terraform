#creating VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "prod-vpc"
    } 
}

#creating subnet
resource "aws_subnet" "prod" {
vpc_id = aws_vpc.prod.id
cidr_block= "10.0.0.0/24"
tags = {
    Name = "subnet-prod"
}
}

#creating subnet2 private

resource "aws_subnet" "prodprivate" {
vpc_id = aws_vpc.prod.id
cidr_block= "10.0.1.0/24"
tags = {
    Name = "private_subnet"
}
}


# Creating an Elastic IP for the NAT Gateway
resource "aws_eip" "ng" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}
#creating nat gateway

resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.ng.id
  subnet_id     = aws_subnet.prod.id

  tags = {
    Name = "gw NAT"
  }
}

#creating route table for natgateway and edit the routes

resource "aws_route_table" "name1" {
    vpc_id = aws_vpc.prod.id
  route{
    gateway_id = aws_nat_gateway.ng.id
    cidr_block = "0.0.0.0/0"
    }
    tags = {
    Name = "private_rt"
}
}

#subnets association for nat gateway

resource "aws_route_table_association" "name1" {
  subnet_id      = aws_subnet.prodprivate.id
  route_table_id = aws_route_table.name1.id
}




#creating Internetgateway

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod_ig"
}
}

#creating route table and edit the routes

resource "aws_route_table" "name" {
    vpc_id = aws_vpc.prod.id
  route{
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
    }
    tags = {
    Name = "public_rt"
}
}

#subnets association

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.prod.id
  route_table_id = aws_route_table.name.id
}

#creating security group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description = "TLS from ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}