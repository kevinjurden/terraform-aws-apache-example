data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_security_group" "sg_test_server" {
  name        = "sg_test_server"
  description = "TestServer Security Group"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [var.my_ip]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = {
    Name = "sg_test_server"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
}

data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

resource "aws_instance" "my_server" {
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = var.instance_size
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_test_server.id]
  user_data              = data.template_file.user_data.rendered
  iam_instance_profile   = "SSMManagedRole"

  tags = {
    Name = var.server_name
  }
}

# Test