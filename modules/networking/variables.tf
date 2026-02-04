variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_CIDR" {
  description = "The CIDR block for the public subnet 1"
  type        = string
}

variable "public_sub_count" {
  description = "Number of public subnets"
  type        = number
}


variable "private_subnet_CIDR" {
  description = "The CIDR block for the private subnet 1"
  type        = string
}

variable "private_sub_count" {
  description = "Number of private subnets"
  type        = number
}


variable "access-ip"  {
  description = "The IP address allowed to access the instances"
  type        = string
}