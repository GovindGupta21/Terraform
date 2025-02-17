resource "aws_instance" "dev" {
  ami = "ami-0c50b6f7dc3701ddd"
  instance_type = "t2.micro"
  key_name = "mumbai"
    
    tags = {
      Name = "dev"
    }
}


terraform {
backend "s3" {
    bucket         = "govindgupta"  # Name of the S3 bucket where the state will be stored.
    region         =  "ap-south-1"
    key            = "day-5/terraform.tfstate" # Path within the bucket where the state will be read/written.
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, note: first run day-4-s3-dynamodb resource then day-4-state-remote-backend
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}