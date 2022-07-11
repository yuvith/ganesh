//variables for rds

variable "environment" {
    description = "The name of the environment"
    default = ""
}

variable "vpc_id" {
    description = "The VPC ID for the rds"
    default = ""
}

variable "vpc_cidr_blocks" {
    default = ""
}

variable "rds_allocated_storage" {
    default = ""
}

variable "rds_instance_class" {
    default = ""
}

variable "availability_zone" {
    default = ""
}

