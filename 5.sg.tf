resource "aws_security_group" "allow_all" {
  name        = "${var.vpc_name}-allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

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

data "http" "my_current_ip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "allow_required" {
  name        = "${var.vpc_name}-allow_required"
  description = "Allow all required traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_current_ip.response_body)}/32"]
    #chomp removes just line ending characters from the end of a string.
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${trimspace(data.http.my_current_ip.response_body)}/32"]
    #trimspace removes any space characters from the start and end of the given string.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}