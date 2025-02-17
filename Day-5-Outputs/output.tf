output "ip" {
  value = aws_instance.dev.public_ip #to call the public ip here after the instance is created
}

output "az" {
    value = aws_instance.dev.availability_zone
}

output "privateip" {
  value = aws_instance.dev.private_ip
  sensitive = true
}

output "sg" {
    value = aws_instance.dev.vpc_security_group_ids
}