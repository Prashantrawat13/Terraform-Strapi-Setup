module "networking" {
  source            = "../modules/networking"
  vpc_cidr          = var.vpc_cidr
  public_sub_count  = var.public_sub_count
  private_sub_count = var.private_sub_count
  access-ip         = var.access-ip

}



module "compute" {
  source = "../modules/compute"
  # VPC
  vpc-id = module.networking.vpc-id
  #Public Subnet and Bastion Host
  public_subnet             = module.networking.public-subnet
  bastion-sg                = module.networking.bastion-sg
  bastion-ec2-ami           = var.bastion-ec2-ami
  bastion-ec2-instance-type = var.bastion-ec2-instance-type
  bastion-host-key          = "${path.module}/modules/compute/keys/id_rsa.pub"
  # web-tier security group and EC2 instance details
  web-tier-sg           = module.networking.web-tier-sg
  web-ec2-ami           = var.web-ec2-ami
  web-ec2-instance-type = var.web-ec2-instance-type
  web_alb_tg_arn = module.alb.web_alb_tg_arn
  #Private Subnet, App tier and Security Groups details 
  private_subnet        = module.networking.private-subnet
  app-tier-sg           = module.networking.app-tier-sg
  app-ec2-ami           = var.app-ec2-ami
  app-ec2-instance-type = var.app-ec2-instance-type
  app_alb_tg_arn = module.alb.app_alb_tg_arn
}



module "alb" {
  source         = "../modules/alb"
  vpc-id         = module.networking.vpc-id
  public_subnet  = module.networking.public-subnet
  private_subnet = module.networking.private-subnet
  bastion-sg     = module.networking.bastion-sg
  external-lb-sg = module.networking.external-lb-sg
  web-tier-sg    = module.networking.web-tier-sg
  internal-lb-sg = module.networking.internal-lb-sg
  app-tier-sg    = module.networking.app-tier-sg

}