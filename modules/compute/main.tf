########## Creating EC2 Instances ##########   || Web Tier EC2 Instance

resource "aws_instance" "web_tier_instance" {

  ami                         = var.web-ec2-ami
  key_name                    = ""
  instance_type               = var.web-ec2-instance-type
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.web_tier_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Web_Tier_Instance"
  }
}


########## Creating EC2 Instances ##########   || App Tier EC2 Instance

resource "aws_instance" "app_tier_instance" {

  ami                         = var.web-ec2-ami
  key_name                    = "login-key.pem"
  instance_type               = var.web-ec2-instance-type
  subnet_id                   = aws_subnet.private_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.app_tier_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "App_Tier_Instance"
  }
}