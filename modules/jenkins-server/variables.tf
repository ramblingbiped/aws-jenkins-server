variable "instance_type" {
    type = string
    description = "EC2 Instance type"
    default = "t2.micro"
}

variable "deployment_name" {
    type = string
    description = "Deployment name used to construct unique ids and attributes related to the deployed resources"
    default = "jenkins-server"
}

variable "vpc_cidr" {
  type        = string
  description = "The cidr to associate with the VPC network"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type        = list(any)
  description = "A list of cidrs to associate with the VPC private subnets"
  default     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
}

variable "public_subnet_cidrs" {
  type        = list(any)
  description = "A list of cidrs to associate with the VPC public subnets"
  default     = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway?"
  default     = false
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "Enable VPN gateway?"
  default     = false
}

variable "http_ingress_allowed_origin_cidrs" {
    type = list(string)
    description = "The list of allowed origins for the Jenkin's instance ingress traffic over TCP port 80 (http)"
    default = [ "0.0.0.0/0" ]
}

variable "jenkins_port" {
    type = number
    description = "TCP port used by the Jenkins service"
    default = 80
}

variable "common_tags" {
    type = map(string)
    default = {}
}