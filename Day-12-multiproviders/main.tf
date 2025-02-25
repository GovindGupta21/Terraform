provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  region = "us-east-1"
  alias = "provider2"
}

resource "aws_instance" "name" {
  ami = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name = "mumbai"
  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket" "name" {
  bucket = "sbjbjsb"
  provider = aws.provider2
}