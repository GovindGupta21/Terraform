resource "aws_s3_bucket" "name" {
  bucket = "qwertyuiopasdfgder"
  depends_on = [ aws_instance.name ]
}

resource "aws_instance" "name" {
  ami = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name = "mumbai"
}