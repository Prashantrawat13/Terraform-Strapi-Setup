####### VPC Module ########
############################

vpc_cidr = "10.0.0.0/16"

public_sub_count = 3

private_sub_count = 3

access-ip = "Put_your_public_ip_here/32"



############ Compute Module #############
########################################

## Bastion Host Variables ##
bastion-ec2-ami = "ami-087d1c9a513324697" # Ubuntu Server 22.04 LTS (HVM),EBS General Purpose (SSD) Volume Type

bastion-ec2-instance-type = "t3.micro"


## Web Tier Variables ##
web-ec2-ami = "ami-087d1c9a513324697" # Ubuntu Server 22.04 LTS (HVM),EBS General Purpose (SSD) Volume Type

web-ec2-instance-type = "t3.medium"


## App Tier Variables ##
app-ec2-ami = "ami-087d1c9a513324697" # Ubuntu Server 22.04 LTS (HVM),EBS General Purpose (SSD) Volume Type

app-ec2-instance-type = "t3.medium"


