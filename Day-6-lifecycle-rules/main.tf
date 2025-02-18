resource "aws_instance" "prod" {
  ami = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name = "mumbai1"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "myserver"
  }
   #lifecycle {
   # ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
    #  tags,
   # ]
  #}

  #lifecycle {
   # create_before_destroy = true
  #}

  #lifecycle {
    #prevent_destroy = true
 # }


}