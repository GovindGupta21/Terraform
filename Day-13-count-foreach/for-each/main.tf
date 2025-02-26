variable "ami" {
  type    = string
  default = "ami-0c50b6f7dc3701ddd"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type    = list(string)
  default = ["dev", "prod"]
}
resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.env)
#   count = length(var.env)

  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }
}