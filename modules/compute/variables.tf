variable "vpc-id" {}
# variable public-subnet {}
# variable private-subnet {}
variable "bastion-sg" {}
variable "web-tier-sg" {}
variable "app-tier-sg" {}
variable "public_subnet" {
  type = list(string)
}

variable "private_subnet" {
  type = list(string)
}


####### Bastion Host Variables #######

variable "bastion-host-key" {
  description = "Public Key for Bastion Host"
  type        = string
}


variable "bastion-ec2-ami" {
  description = "AMI ID for Bastion Host EC2 Instance"
  type        = string
}

variable "bastion-ec2-instance-type" {
  description = "Instance Type for Bastion Host EC2 Instance"
  type        = string
}




#### Web Tier Variables #######
variable "web-ec2-ami" {
  description = "AMI ID for Web Tier EC2 Instance"
  type        = string
}


variable "web-ec2-instance-type" {
  description = "Instance Type for Web Tier EC2 Instance"
  type        = string
}


#### App Tier Variables #######

variable "app-ec2-ami" {
  description = "AMI ID for App Tier EC2 Instance"
  type        = string
}

variable "app-ec2-instance-type" {
  description = "Instance Type for App Tier EC2 Instance"
  type        = string
}





variable "web_alb_tg_arn" {}

variable "app_alb_tg_arn" {}

