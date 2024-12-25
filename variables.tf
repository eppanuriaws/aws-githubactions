variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "key_name" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "Main_Routing_Table" {}
variable "azs" {}
variable "environment" {}
variable "owner" {}
variable "imagename" { type = map(any) }
variable "instance_type" {}
variable "ingress_ports" {}
variable "egress_ports" {}
variable "version_for_trigger" {}

