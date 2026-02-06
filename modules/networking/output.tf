output "vpc-id" {
  value = aws_vpc.main.id
}

output "public-subnet" {
  value = aws_subnet.public.*.id
}

output "private-subnet" {
  value = aws_subnet.private.*.id
}

output "bastion-sg" {
  value = aws_security_group.Bastion-Host-SG.id
}

output "external-lb-sg" {
    value = aws_security_group.External-LB-SG.id
}

output "web-tier-sg" {
    value = aws_security_group.Web-Tier-SG.id
}

output "internal-lb-sg" {
    value = aws_security_group.Internal-LB-SG.id
}

output "app-tier-sg" {
    value = aws_security_group.App-Tier-SG.id
}


