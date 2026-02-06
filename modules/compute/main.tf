######## Key pairs ########

resource "aws_key_pair" "bastion-host-key-pair" {
  key_name   = "bastion-host"
  public_key = file("${path.module}/keys/id_rsa.pub")
}



########## Launch Template and Auto Scaling for Bastion Host ##########

resource "aws_launch_template" "bastion_host_template" {
  name_prefix            = "bastion-host-instance"

  image_id               = var.bastion-ec2-ami
  instance_type          = var.bastion-ec2-instance-type
  key_name               = aws_key_pair.bastion-host-key-pair.key_name

vpc_security_group_ids = [var.bastion-sg]
  # network_interfaces {
  #     associate_public_ip_address = true
  #   security_groups = [var.bastion-sg]
  # }

  tags = {
    Name = "Bastion_Host_Instance"
  }
}



resource "aws_autoscaling_group" "bastion_host_asg" {
  name                = "bastion-host"
  vpc_zone_identifier = var.public_subnet
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.bastion_host_template.id
    version = "$Latest"
  }

  health_check_type = "ELB"
  health_check_grace_period = 300

tag {
    key                 = "Name"
    value               = "Bastion Host"
    propagate_at_launch = false
  }
}






########## Launch Template and Auto Scaling for Web-Tier ##########

resource "aws_launch_template" "web_tier_template" {
  name_prefix            = "web_tier_instance"

  image_id               = var.web-ec2-ami
  instance_type          = var.web-ec2-instance-type
  key_name               = aws_key_pair.bastion-host-key-pair.key_name
  
  vpc_security_group_ids = [var.web-tier-sg]
  user_data              = filebase64("${path.module}/install_docker.sh")


  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  tags = {
    Name = "Web_Tier_Instance"
  }
}



resource "aws_autoscaling_group" "web_tier_asg" {
  name = "web-tier-asg"

  vpc_zone_identifier = var.public_subnet
  min_size            = 2
  max_size            = 8
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.web_tier_template.id
    version = "$Latest"
  }

    target_group_arns = [var.web_alb_tg_arn]

  health_check_type = "ELB"
  health_check_grace_period = 300

tag {
    key                 = "Name"
    value               = "Web Tier Instance"
    propagate_at_launch = false
  }
}







########## Launch Template and Auto Scaling for App-Tier ##########


resource "aws_launch_template" "app_tier_template" {
  name_prefix            = "app_tier_instance"

  image_id               = var.app-ec2-ami
  instance_type          = var.app-ec2-instance-type
  key_name               = aws_key_pair.bastion-host-key-pair.key_name

  vpc_security_group_ids = [var.app-tier-sg]
  # user_data = file("${path.module}/install_docker.sh")
  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  tags = {
    Name = "App_Tier_Instance"
  }
}



resource "aws_autoscaling_group" "app_tier_asg" {
  name                = "app-tier-asg"
  vpc_zone_identifier = var.private_subnet
  min_size            = 2
  max_size            = 8
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.app_tier_template.id
    version = "$Latest"
  }

    target_group_arns = [var.app_alb_tg_arn]

  health_check_type = "ELB"
  health_check_grace_period = 300

tag {
    key                 = "Name"
    value               = "App Tier Instance"
    propagate_at_launch = false
  }
}

