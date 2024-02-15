output "vpc_id" {
  value = aws_vpc.vpc_1.id
}

output "pub_subnet_id" {
  value = aws_subnet.pub_subnet.id
}

output "priv_subnet_id" {
  value = aws_subnet.priv_subnet.id
}

output "db_subnet_id" {
  value = aws_subnet.db_subnet.id
}

output "db_subnet_id_2" {
  value = aws_subnet.db_subnet_2.id
}

output "gw_1_id" {
  value = aws_internet_gateway.gw_1.id
}

output "rt_1_id" {
  value = aws_route_table.rt_1.id
}
