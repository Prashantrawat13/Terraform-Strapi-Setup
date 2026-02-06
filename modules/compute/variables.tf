variable "vpc-id" {}
variable public-subnet {}
variable private-subnet {}
variable "bastion-sg" {}
variable "external-lb-sg" {}
variable "web-tier-sg" {}
variable "internal-lb-sg" {}
variable "app-tier-sg" {}


####### Bastion Host Variables #######

variable "bastion-host-key" {
  description = "Public Key for Bastion Host"
  type        = string
}

variable "public-key-path" {
  description = "Path to the public key file for Bastion Host"
  type        = string
  default = "${path.module}/keys/id_rsa.pub"
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