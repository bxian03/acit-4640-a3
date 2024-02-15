resource "aws_security_group" "sg_self" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name    = var.sg_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each          = {
    for index, rule in var.ingress_rules: 
    rule.rule_name => rule
  }

  description       = each.value.description
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  security_group_id = aws_security_group.sg_self.id
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  for_each          = {
    for index, rule in var.egress_rules: 
    rule.rule_name => rule
  }

  security_group_id = aws_security_group.sg_self.id
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  from_port = each.value.from_port
  to_port = each.value.to_port
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

