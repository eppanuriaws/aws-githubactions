#Pass a list value to toset to convert it to a set(remove Duplicates), 
#which will remove any duplicate elements and discard the ordering of the elements.
locals {
  ingress      = toset(var.ingress_ports)
  egress       = toset(var.egress_ports)
  current_time = timestamp()
  vpc_name     = lower(var.vpc_name)
  owner        = lower(var.owner)
  environment  = upper(var.environment)
  #toset will remove duplicates and discard the ordering of the elements.
  set = toset([4445, 4444, 32000, 32111, 32222, 9111, 9100, 111, 222, 333, 555, 555, 666, 666, 777, 777, 80, 443, 444, 333, 222, 111, 111, 222, 333, 1433, 1445, 7000, 7001, 7000, 7001])
  #distinct will remove duplicates and keep the ordering of the elements.
  dist = distinct([4445, 4444, 32000, 32111, 32222, 9111, 9100, 111, 222, 333, 555, 555, 666, 666, 777, 777, 80, 443, 444, 333, 222, 111, 111, 222, 333, 1433, 1445, 7000, 7001, 7000, 7001])
}


resource "aws_security_group" "sg_dynamic" {
  name        = "sg_dynamic"
  description = "Allow all inbound traffic using Dynamic Blocks"
  vpc_id      = aws_vpc.default.id
  dynamic "ingress" {
    for_each = local.ingress
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      #chomp removes newline characters at the end of a string.
      cidr_blocks = ["0.0.0.0/0", "${chomp(data.http.my_current_ip.response_body)}/32"]
    }
  }


  dynamic "egress" {
    for_each = local.egress
    content {
      from_port = egress.value
      to_port   = egress.value
      protocol  = "tcp"
      #chomp removes newline characters at the end of a string.
      cidr_blocks = ["0.0.0.0/0", "${chomp(data.http.my_current_ip.response_body)}/32"]
    }
  }

  tags = {
    Name        = "${local.vpc_name}-Dynamic-SG"
    Environment = local.environment
    Owner       = local.owner
  }
}

