resource "aws_instance" "public-servers" {
  count         = var.environment == "dev" || var.environment == "Development" ? 3 : 1
  ami           = lookup(var.imagename, var.aws_region, "ami-0e001c9271cf7f3b9")
  subnet_id     = element(aws_subnet.public-subnets[*].id, count.index)
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.allow_all.id,
    aws_security_group.allow_required.id
  ]
  associate_public_ip_address = true
  tags = {
    Name    = "${var.vpc_name}-Public-Server-${count.index + 1}"
    Env     = var.environment
    Owner   = var.owner
    Version = var.version_for_trigger
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx jq net-tools unzip -y
    sudo systemctl start nginx && sudo systemctl enable nginx
    sudo echo "${var.vpc_name}-Public-Server-${count.index + 1}" > /var/www/html/index.nginx-debian.html
    EOF

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
    ignore_changes = [
      user_data
    ]
  }
}