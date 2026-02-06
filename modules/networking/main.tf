##### Creating VPC #####

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = "ap-south-1"
  tags = {
    Name = "My_VPC"
  }
}


data "aws_availability_zones" "available" {
}



##### Public Subnet #####          || Web-Tier

resource "aws_subnet" "public_subnet" {
  count = var.public_sub_count
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_CIDR
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet${count.index + 1}" 
}
}



##### Internet Gateway #####

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "My_Internet_Gateway"
  }
}



##### Public Route Table #####

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Public_Route_Table"
  }
}

resource "aws_route" "Public-RT-route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id

}


resource "aws_route_table_association" "public_rt_1" {
  count          = var.public_sub_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}




######## Private Subnet ########     || App-Tier 
resource "aws_subnet" "private_subnet" {
  count                   = var.private_sub_count
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_CIDR
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet${count.index + 1}"
  }
}


##### NAT Gateway and EIP #####

resource "aws_eip" "nat_eip" {

  tags = {
    Name = "Nat_EIP"
  }
}

resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "My_Nat_Gateway"
  }
}



##### Creating Private Route Table #####

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Private_Route_Table"
  }
}

resource "aws_route" "Private-RT-route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.my_nat_gw.id

}


resource "aws_route_table_association" "private_rt_1" {
  count          = var.private_sub_count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}








####### Security Group #######      || Web-Tier Security Group

resource "aws_security_group" "bastion-host-sg" {
  name        = "Bastion_Host_SG"
  description = "Allow SSH Inbound Traffic from set of IP addresse"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow inbound traffic from Web-Tier SG"
    cidr_blocks = [var.access-ip]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Bastion_Host_SG"
  }
}



####### Security Group #######      || LB-SG

resource "aws_security_group" "external-lb-sg" {
  name        = "External_LB_SG"
  description = "Allow HTTP and HTTPS Inbound Traffic from Internet"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow Http inbound traffic from Internet"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Allow Https inbound traffic from Internet"
    cidr_blocks     = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "External_LB_SG"
  }
}




####### Security Group #######      || Web-Tier SG


resource "aws_security_group" "web-tier-sg" {

  name        = "Web_Tier_SG"
  description = "Allow HTTP and HTTPS Inbound Traffic from external-lb-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow Http inbound traffic from external-lb-sg"
    security_groups = [aws_security_group.external-lb-sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Allow Https inbound traffic from external-lb-sg"
    security_groups = [aws_security_group.external-lb-sg.id] 
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Web_Tier_SG"
  }
}




####### Security Group #######      || Internal-LB-SG


resource "aws_security_group" "internal-lb-sg" {

  name        = "Internal_LB_SG"
  description = "Allow All Traffic from the Web-Tier SG"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow http inbound traffic from Internal SG"
    security_groups = [aws_security_group.web-tier-sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Allow https inbound traffic from Internal SG"
    security_groups = [aws_security_group.web-tier-sg.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




####### Security Group #######      || App-Tier-SG


resource "aws_security_group" "app-tier-sg" {
  name        = "App_Tier_SG"
  description = "Allow All Traffic from the Internal-LB-SG" 
  vpc_id      = aws_vpc.my_vpc.id
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow http inbound traffic from internal-lb-sg"
    security_groups = [aws_security_group.internal-lb-sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Allow https inbound traffic from internal-lb-sg"
    security_groups = [aws_security_group.internal-lb-sg.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App_Tier_SG"
  }
  }