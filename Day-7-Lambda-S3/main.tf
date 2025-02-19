# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "lambdasriyukth"
  force_destroy = true
}

#to convert into zip file
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"   # Python script to be zipped
  output_path = "lambda_function.zip"  # Output ZIP file
}


# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket     = aws_s3_bucket.lambda_bucket.id
  key        = "lambda_function.zip"
  source     = data.archive_file.lambda_zip.output_path
  etag       = filemd5(data.archive_file.lambda_zip.output_path)

  depends_on = [data.archive_file.lambda_zip]  # Ensures ZIP is created first
}


# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler" # Replace with your function handler
  s3_bucket        = aws_s3_bucket.lambda_bucket.id # calling code from s3 bucket 
  s3_key           = aws_s3_object.lambda_code.key # inside this folder
  timeout          = 10
  memory_size      = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example environment variable
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}