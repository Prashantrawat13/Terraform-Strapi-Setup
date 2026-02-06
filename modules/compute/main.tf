######## Key pairs ########

resource "aws_key_pair" "bastion-host-key-pair" {
  key_name   = "bastion-host"
  public_key = file(var.public-key-path)
}




########## Launch Template and Auto Scaling for Bastion Host ##########

resource "aws_launch_template" "bastion_host_template" {
  name_prefix          = "bastion-host-"
  image_id             = var.bastion-ec2-ami
  instance_type        = var.bastion-ec2-instance-type
  key_name             = aws_key_pair.bastion-host-key-pair.key_name
  security_group_names = [var.bastion-sg]
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public-subnet
  }

  tags = {
    Name = "Bastion_Host_Instance"
  }
}



resource "aws_autoscaling_group" "bastion_host_asg" {
  name                = "bastion-host"
  vpc_zone_identifier = var.public-subnet
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.bastion_host_template.id
    version = "$Latest"
  }
}






########## Launch Template and Auto Scaling for Web-Tier ##########

resource "aws_launch_template" "web_tier_template" {
  name_prefix          = "web_tier_instance"
  image_id             = var.web-ec2-ami
  instance_type        = var.web-ec2-instance-type
  key_name             = aws_key_pair.bastion-host-key-pair.key_name
  security_group_names = [var.web-tier-sg]
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public-subnet
  }

  tags = {
    Name = "Web_Tier_Instance"
  }
}



resource "aws_autoscaling_group" "web_tier_asg" {
  name                = "web-tier-asg"
  
  vpc_zone_identifier = var.public-subnet
  min_size            = 2
  max_size            = 8
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.web_tier_template.id
    version = "$Latest"
  }
}







########## Launch Template and Auto Scaling for App-Tier ##########


resource "aws_launch_template" "app_tier_template" {
  name_prefix          = "app_tier_instance"
  image_id             = var.app-ec2-ami
  instance_type        = var.app-ec2-instance-type
  key_name             = aws_key_pair.bastion-host-key-pair.key_name
  security_group_names = [var.app-tier-sg]
  user_data = file("${path.module}/script.sh")
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public-subnet
  }

  tags = {
    Name = "App_Tier_Instance"
  }
}



resource "aws_autoscaling_group" "app_tier_asg" {
  name                = "app-tier-asg"
  vpc_zone_identifier = var.public-subnet
  min_size            = 2
  max_size            = 8
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.app_tier_template.id
    version = "$Latest"
  }
}
