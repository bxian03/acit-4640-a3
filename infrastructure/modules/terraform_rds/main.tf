resource "aws_db_subnet_group" "subnet_group" {
  subnet_ids = [ var.subnet_group_id_1, var.subnet_group_id_2 ]
}

resource "aws_db_instance" "db" {
  instance_class = "db.t2.micro"
  engine = "mysql"
  engine_version = "8.0.35"
  username = "ansible"
  password = "Never-Outhouse-Amount-Ammonium1"
  allocated_storage = "5"
  port = 3306
  skip_final_snapshot = true
  multi_az = false
  vpc_security_group_ids = [ var.security_group_id ]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  tags = {
    Name = var.db_name
    Project =  var.project_name
  }
}