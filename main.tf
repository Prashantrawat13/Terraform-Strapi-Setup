module "VPC" {
  source = "./modules/VPC"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_CIDR = "10.0.1.0/24"
  private_subnet_CIDR = "10.0.2.0/24"
}