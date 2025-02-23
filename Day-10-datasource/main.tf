data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["subnet1"] # insert value here
  }
}
data "aws_security_groups" "selected" {
  filter {
    name   = "tag:Name"
    values = ["raj"] # insert value here
  }
}


resource "aws_instance" "dev" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.selected.id
    vpc_security_group_ids = [data.aws_security_groups.selected.ids[0]]

}