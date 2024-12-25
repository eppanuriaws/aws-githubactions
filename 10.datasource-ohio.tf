provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}

data "aws_vpc" "ohio-vpc" {
  provider = aws.ohio
  id       = "vpc-0218789c729818ae2"
}

resource "aws_security_group" "ohio_allow_all" {
  provider    = aws.ohio
  name        = "ohio_allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = data.aws_vpc.ohio-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_subnet" "ohio-subnet" {
  provider = aws.ohio
  id       = "subnet-022f6322f847ec81a"
}

resource "aws_instance" "public-servers-ohio" {
  provider      = aws.ohio
  count         = 1
  ami           = lookup(var.imagename, "us-east-2", "ami-0e001c9271cf7f3b9")
  subnet_id     = data.aws_subnet.ohio-subnet.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.ohio_allow_all.id
  ]
  associate_public_ip_address = true
  tags = {
    Name  = "${var.vpc_name}-Public-Server-${count.index + 1}"
    Env   = var.environment
    Owner = var.owner
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx jq net-tools unzip -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo echo "${var.vpc_name}-Public-Server-${count.index + 1}" > /var/www/html/index.nginx-debian.html
    EOF
}
