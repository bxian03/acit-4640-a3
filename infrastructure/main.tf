module "a03_vpc" {
  source        = "./modules/terraform_vpc"
  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  pub_subnet    = var.pub_subnet
  priv_subnet   = var.priv_subnet
  db_subnet     = var.db_subnet
  db_subnet_2   = var.db_subnet_2
  default_route = var.default_route
}

module "pub_sg" {
  source            = "./modules/terraform_sg"
  vpc_id            = module.a03_vpc.vpc_id
  project_name      = var.project_name
  sg_name           = var.pub_sg_name
  sg_description    = "Allow http and ssh access to ec2 from home and bcit"
  ingress_rules = [ 
    {
      description = "ssh access from home"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.home_net
      rule_name = "ssh_access_home"
    },
    {
      description = "ssh access from bcit"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.bcit_net
      rule_name = "ssh_access_bcit"
    },
    {
      description = "web access from home"
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_ipv4 = var.home_net
      rule_name = "web_access_home"
    },
    {
      description = "web access from bcit"
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_ipv4 = var.bcit_net
      rule_name = "web_access_bcit"
    },
    {
      description = "allow all from backend"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = var.priv_subnet
      rule_name = "allow all from backend"
    }
   ]
  egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = "0.0.0.0/0"
      rule_name = "allow_all_egress"
    }
   ]
}

module "priv_sg" {
  source            = "./modules/terraform_sg"
  vpc_id            = module.a03_vpc.vpc_id
  project_name      = var.project_name
  sg_name           = var.priv_sg_name
  sg_description    = "Allow ssh access to ec2 from home and bcit"
  ingress_rules = [ 
    {
      description = "ssh access from home"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.home_net
      rule_name = "ssh_access_home"
    },
    {
      description = "ssh access from bcit"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.bcit_net
      rule_name = "ssh_access_bcit"
    },
    {
      description = "allow all from vpc"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = var.vpc_cidr
      rule_name = "all_access_vpc"
    }
   ]
  egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = "0.0.0.0/0"
      rule_name = "allow_all_egress"
    }
   ]
}

module "db_sg" {
  source = "./modules/terraform_sg"
  vpc_id = module.a03_vpc.vpc_id
  project_name = var.project_name
  sg_name = var.db_sg_name
  sg_description = "allow 3306 from backend"
  ingress_rules = [ 
    {
      description = "allow 3306 from backend"
      ip_protocol = "tcp"
      from_port = 3306
      to_port = 3306
      cidr_ipv4 = var.priv_subnet
      rule_name = "backend_3306"
    }
   ]
  egress_rules = [ 
    {
      description = "allow 3306 egress traffic"
      ip_protocol = "tcp"
      from_port = 3306
      to_port = 3306
      cidr_ipv4 = var.priv_subnet
      rule_name = "allow_3306_egress"
    }
   ]
}

module "web_ec2" {
  source = "./modules/terraform_ec2"
  aws_region = var.aws_region
  subnet_id = module.a03_vpc.pub_subnet_id
  security_group_id = module.pub_sg.sg_id
  ec2_name = var.web_ec2_name
  ami_id = var.ami_id
  project_name = var.project_name
}

module "backend_ec2" {
  source = "./modules/terraform_ec2"
  aws_region = var.aws_region
  subnet_id = module.a03_vpc.priv_subnet_id
  security_group_id = module.priv_sg.sg_id
  ec2_name = var.backend_ec2_name
  ami_id = var.ami_id
  project_name = var.project_name
}

module "db" {
  source = "./modules/terraform_rds"
  db_name = var.db_name
  subnet_group_id_1 = module.a03_vpc.db_subnet_id
  subnet_group_id_2 = module.a03_vpc.db_subnet_id_2
  security_group_id = module.db_sg.sg_id
  project_name = var.project_name
}


### Uncomment for inventory file creation
# resource "local_file" "inventory_file" {

#   content = <<EOF
# webservers:
#   hosts:
#     ${module.web_ec2.ec2_instance_public_dns}
# backend:
#   hosts:
#     ${module.backend_ec2.ec2_instance_public_dns}
# EOF

#   filename = "../service/inventory/servers.yml"

# }

resource "local_file" "group_vars_file" {

  content = <<EOF
web_public_dns: ${module.web_ec2.ec2_instance_public_dns}
web_ip: ${module.web_ec2.ec2_instance_private_ip}
backend_ip: ${module.backend_ec2.ec2_instance_private_ip}
db_address: ${module.db.db_address}
EOF

  filename = "../service/group_vars/servers.yml"

}