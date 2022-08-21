# Provide RDS instance
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = data.terraform_remote_state.eks.outputs.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds" {
  identifier             = "postgres-diploma-rds"
  allocated_storage      = 5
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres14"
  skip_final_snapshot    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [data.terraform_remote_state.eks.outputs.nodes_sg]

  tags = {
    Name = "postgres-diploma-rds"
  }
}
