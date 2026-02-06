####### VPC Module ########
############################

variable "vpc_cidr" {}

variable "public_sub_count" {}

variable "private_sub_count" {}

variable "access-ip" {}




###################################################
########## Compute Module Variables ################
#####################################################
variable "bastion-ec2-ami" {}

variable "bastion-ec2-instance-type" {}



#### Web Tier Variables #######
variable "web-ec2-ami" {}

variable "web-ec2-instance-type" {}


#### App Tier Variables #######

variable "app-ec2-ami" {}

variable "app-ec2-instance-type" {}






