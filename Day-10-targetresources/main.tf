resource "aws_instance" "dependent" {
    ami = "ami-0c50b6f7dc3701ddd"
    instance_type = "t2.micro"
    key_name = "mumbai"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "ytvhshfbbcerrr" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent

#Example below for multiple targets
#terraform apply -target=aws_s3_bucket.dependent -target=aws_instance.dev -target=aws_db_instance.database