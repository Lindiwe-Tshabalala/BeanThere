provider "aws" {
  region = var.region
}

# Fetch the existing VPC by filtering by tag or name
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Fetch existing private subnets in the VPC
data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

# Fetch existing security group by name or tag
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }
}

# Fetch the existing DB subnet group
data "aws_db_subnet_group" "existing_db_subnet_group" {
  name = var.db_subnet_group_name
}

resource "aws_db_instance" "bean_there_db" {
  allocated_storage    = var.allocated_storage
  storage_type        = "gp2"
  engine              = "sqlserver-ex"
  engine_version      = "15.00.4415.2.v1"
  instance_class      = var.instance_class
  identifier          = var.db_instance_identifier
  username            = var.username
  password            = var.password
  publicly_accessible = true
  skip_final_snapshot = true
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  db_subnet_group_name   = data.aws_db_subnet_group.existing_db_subnet_group.name  # Use existing subnet group
}
