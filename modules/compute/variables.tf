

variable "web-ec2-ami" {
  description = "AMI ID for Web Tier EC2 Instance"
  type        = string
}


variable "web-ec2-instance-type" {
  description = "Instance Type for Web Tier EC2 Instance"
  type        = string
}

variable "app-ec2-ami" {
  description = "AMI ID for App Tier EC2 Instance"
  type        = string
}

variable "app-ec2-instance-type" {
  description = "Instance Type for App Tier EC2 Instance"
  type        = string
}