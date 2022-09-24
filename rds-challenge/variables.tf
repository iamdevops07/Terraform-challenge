variable "region" {
    type = string
    default = "ap-south-1"  
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}