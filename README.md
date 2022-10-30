Terraform Module to provision an EC2 instance that will be running Apache.

Not intended for production use. Just used for showcasing and learning.

'''hcl
terraform {
  
}

provider "aws" {
  region  = "us-east-1"
}

module "apache" {
  source = ".//terraform-aws-apache-example"
  
  vpc_id = "vpc-0000000"
  my_ip = "MY_PUBLIC_IP_ADDRESS/32"
  server_name = "Name of EC2 Instance"
  instance_size = "t2.micro"
  public_key = "ssh-rsa AAA..."
}

output "public_ip" {
  value = module.apache.public_ip
}
'''