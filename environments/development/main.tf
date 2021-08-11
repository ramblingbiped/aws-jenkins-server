provider "aws" {
    region = var.region
    profile = var.aws_profile
    default_tags {
        tags = var.common_tags
    }
}

module "jenkins-server" {
  source = "../../modules/jenkins-server"
  http_ingress_allowed_origin_cidrs = var.http_ingress_allowed_origin_cidrs
  instance_type = var.instance_type

}