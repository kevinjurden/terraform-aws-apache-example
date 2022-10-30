variable "vpc_id" {
  type = string
}

variable "my_ip" {
  type        = string
  description = "Your public IP address, ex: 102.23.1.99/32"
}

variable "instance_size" {
  type        = string
  description = "The size of the EC2 instance, ex: t2.micro"
  default     = "t2.micro"
}

variable "server_name" {
  type        = string
  description = "The name of the EC2 instance"
  default     = "Apache Server"
}

variable "public_key" {
  type        = string
  description = "The RSA public key that will be used to access the EC2 instance"
}