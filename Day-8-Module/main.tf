module "day8" {
  source = "../Day-8-Module-Source-Code"
  ami = "ami-0c50b6f7dc3701ddd"
  instance = "t2.micro"
  key = "mumbai"
  instancename = "myserver"
}