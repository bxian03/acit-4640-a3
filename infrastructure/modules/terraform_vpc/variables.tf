# Define Variables the values are outside this file 
variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "availability_zone" {
  description = "AWS region availability zone"
  default = "us-west-2a"
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
  default     = "192.168.1.2.0/24"
}

variable "priv_subnet" {
  description = "private subnet CIDR"
  default     = "192.168.1.0/24"
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
