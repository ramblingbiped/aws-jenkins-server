data "aws_availability_zones" "availability-zones" {
  
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.2.0"

    name = "${var.deployment_name}-vpc"
    cidr = var.vpc_cidr
    azs = data.aws_availability_zones.availability-zones.names[*]
    private_subnets = var.private_subnet_cidrs
    public_subnets = var.public_subnet_cidrs

    enable_nat_gateway = var.enable_nat_gateway
    enable_vpn_gateway = var.enable_vpn_gateway
}