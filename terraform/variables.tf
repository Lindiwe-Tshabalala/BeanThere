variable "region" {
  description = "AWS region"
}

variable "vpc_name" {
  description = "Name of the existing VPC"
  default     = "bean-there-vpc"  
}

variable "security_group_name" {
  description = "Name of the security group"
  default     = "BeanThereSG"  
}

variable "allocated_storage" {
  description = "Database allocated storage"
  default     = 20  
}

variable "instance_class" {
  description = "Database instance class"
  default     = "db.t3.micro" 
}

variable "db_instance_identifier" {
  description = "Database instance identifier"
  default     = "bean-there-db"
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "DB subnet group name"
  default     = "bean-there-db-subnet-group"  
}
