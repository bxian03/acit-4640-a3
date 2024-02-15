# Terraform Input  Variables
# Resources:
#  - Tutorial: https: //developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-variables
#  - Reference: https://developer.hashicorp.com/terraform/language/values/variables
aws_region      = "us-west-2"
project_name    = "a03"
vpc_cidr        = "192.168.0.0/16"
priv_subnet     = "192.168.1.0/24"
pub_subnet      = "192.168.2.0/24"
db_subnet       = "192.168.3.0/24"
db_subnet_2     = "192.168.4.0/24"
default_route   = "0.0.0.0/0"
home_net        = "205.250.0.0/16"
bcit_net        = "142.232.0.0/16"
ami_id          = "ami-04203cad30ceb4a0c"
ssh_key_name    = "acit_4640"
pub_sg_name     = "pub_sg"
priv_sg_name    = "priv_sg"
db_sg_name      = "db_sg"
web_ec2_name    = "web"
backend_ec2_name = "backend"
db_name         = "db"