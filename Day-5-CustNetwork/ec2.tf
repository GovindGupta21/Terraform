#creating public instance

resource "aws_instance" "prod" {
  ami = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name = "mumbai"
  subnet_id = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true #Ensure instance gets a public IP
    tags = {
      Name = "prod"
    }
}

#creating private instance

resource "aws_instance" "prod1" {
  ami = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name = "mumbai"
  subnet_id = aws_subnet.prodprivate.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = {
      Name = "privateserver"
    }
}