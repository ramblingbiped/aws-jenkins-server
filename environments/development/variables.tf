variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "common_tags" {
    type = map(string)
    default = {}
}

variable "aws_profile" {
    description = "The aws profile to reference during configuration of the AWS provider"
    type = string
    default = "default"
}

variable "http_ingress_allowed_origin_cidrs" {
    type = list(string)
    description = "The list of allowed origins for the Jenkin's instance ingress traffic over TCP port 80 (http)"
    default = [ "0.0.0.0/0" ]
}

variable "deployment_name" {
    type = string
    description = "Name of the deployment"
}

variable "instance_type" {
    type = string
    description = "The AWS EC2 Instance type to be used for the Jenkins server"
    default = "t2.micro"
}