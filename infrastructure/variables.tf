# Define Variables the values are outside this file 
variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "192.168.0.0/16"
}

variable "pub_subnet" {
  description = "public subnet CIDR"
  default     = "192.168.2.0/24"
}

variable "priv_subnet" {
  description = "private subnet CIDR"
  default = "192.168.1.0/24"
}

variable "db_subnet" {
  description = "db private subnet CIDR"
  default = "192.168.3.0/24"
}

variable "db_subnet_2" {
  description = "second db private subnet CIDR for RDS"
  default = "192.168.4.0/24"
}

variable "default_route" {
  description = "Default route"
  default     = "0.0.0.0/0"
}

variable "home_net" {
  description = "Home network"
  default     = "205.250.0.0/16"
}

variable "bcit_net" {
  description = "BCIT network"
  default     = "142.232.0.0/16"
}

variable "ami_id" {
  description = "AMI ID"
}

variable "ssh_key_name" {
  description = "AWS SSH key name"
  default     = "acit_4640"
}

variable "pub_sg_name" {
  description = "public security group name"
  default = "pub_sg"
}

variable "priv_sg_name" {
  description = "private security group name"
  default = "priv_sg"
}

variable "db_sg_name" {
  description = "db security group name"
  default = "db_sg"
}

variable "web_ec2_name" {
  description = "name of web ec2 instance"
  default = "web"
}

variable "backend_ec2_name" {
  description = "name of backend ec2 instance"
  default = "backend"
}

variable "db_name" {
  description = "name of rds db"
  default = "db"
}