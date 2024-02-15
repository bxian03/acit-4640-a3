output "vpc_id" {
  value = module.a03_vpc.vpc_id
}

output "pub_subnet_id" {
  value = module.a03_vpc.pub_subnet_id
}

output "priv_subnet_id" {
  value = module.a03_vpc.priv_subnet_id
}

output "db_subnet_id" {
  value = module.a03_vpc.db_subnet_id
}

output "gw_1_id" {
  value = module.a03_vpc.gw_1_id
}

output "rt_1_id" {
  value = module.a03_vpc.rt_1_id
}

output "pub_sg_id" {
  value = module.pub_sg.sg_id
}

output "priv_sg_id" {
  value = module.priv_sg.sg_id
}

output "db_sg_id" {
  value = module.db_sg.sg_id
}

output "web_ec2_id" {
  value = module.web_ec2.ec2_instance_id
}

output "web_ec2_ip" {
  value = module.web_ec2.ec2_instance_public_ip
}

output "web_ec2_dns" {
  value = module.web_ec2.ec2_instance_public_dns
}

output "backend_ec2_id" {
  value = module.backend_ec2.ec2_instance_id
}

output "backend_ec2_ip" {
  value = module.backend_ec2.ec2_instance_public_ip
}

output "backend_ec2_dns" {
  value = module.backend_ec2.ec2_instance_public_dns
}

output "db_id" {
  value = module.db.rds_instance_id
}

output "db_address" {
  value = module.db.db_address
}