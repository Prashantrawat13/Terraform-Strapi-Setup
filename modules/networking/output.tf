output "vpc-id" {
  value = aws_vpc.my_vpc.id
}

output "public-subnet" {
  value = aws_subnet.public_subnet[*].id
   }

output "private-subnet" {
  value = aws_subnet.private_subnet[*].id
}

output "bastion-sg" {
  value = aws_security_group.bastion-host-sg.id
}

output "external-lb-sg" {
    value = aws_security_group.external-lb-sg.id
}

output "web-tier-sg" {
    value = aws_security_group.web-tier-sg.id
}

output "internal-lb-sg" {
    value = aws_security_group.internal-lb-sg.id
}

output "app-tier-sg" {
    value = aws_security_group.app-tier-sg.id
}


