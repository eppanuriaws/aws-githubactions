aws_region         = "us-east-1"
vpc_cidr           = "10.42.0.0/16"
vpc_name           = "DevSecOpsB42"
Main_Routing_Table = "Terraform_Main_table-testing"
key_name           = "madhavi500"
environment        = "dev"
public_subnet_cidrs = [
  "10.42.1.0/24",
  "10.42.2.0/24",
  "10.42.3.0/24",
  "10.42.4.0/24",
  "10.42.5.0/24",
  "10.42.6.0/24"
]
private_subnet_cidrs = [
  "10.42.10.0/24",
  "10.42.20.0/24",
  "10.42.30.0/24",
  "10.42.40.0/24",
  "10.42.50.0/24",
  "10.42.60.0/24"
]
azs   = ["us-east-1a", "us-east-1b", "us-east-1c"]
owner = "DevOpsTeam"
imagename = {
  "us-east-1" = "ami-08fcfa817c2b32d68"
  "us-east-2" = "ami-09cf08e7d1451bbd2"
}
instance_type       = "t2.micro"
ingress_ports       = [31122, 4445, 4444, 32000, 32111, 32222, 9111, 9100, 111, 222, 333, 555, 555, 666, 666, 777, 777, 80, 443, 444, 333, 222, 111, 111, 222, 333, 1433, 1445, 7000, 7001, 7000, 7001]
egress_ports        = [31123, 4445, 4444, 32000, 32111, 32222, 9111, 8000, 111, 222, 333, 555, 555, 666, 666, 777, 777, 444, 888, 777, 666, 666, 777, 888, 666, 777, 888, 7000, 7001, 7000, 7001]
version_for_trigger = "3.0"



