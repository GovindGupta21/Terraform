resource "aws_instance" "prod" {
  ami = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name = "mumbai1"
  tags = {
    Name = "myserver"
  }
}