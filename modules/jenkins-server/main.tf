data "aws_ami" "amazon-linux-2" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "owner-alias"
        values = ["amazon"]
    }

    filter {
        name = "name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_instance" "jenkins-server" {
    ami = data.aws_ami.amazon-linux-2.id
    instance_type = var.instance_type
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.jenkins-server-sg.id]
    subnet_id = module.vpc.public_subnets[0]
    key_name = "will-test"

    user_data = file("${path.module}/user_data.sh")

    tags = merge(
        var.common_tags,
        {
            Name = "${var.deployment_name}"
        }
    )
}

resource "aws_security_group" "jenkins-server-sg" {
    name = "${var.deployment_name}-sg"
    description = "${var.deployment_name} ec2 instance security group"
    vpc_id = module.vpc.vpc_id

    ingress = [
        {
            description = "Allow HTTP from Public"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = var.http_ingress_allowed_origin_cidrs
            ipv6_cidr_blocks = null
            prefix_list_ids = null
            security_groups = null
            self = null
        },
        {
            description = "Allow SSH from Public"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = var.http_ingress_allowed_origin_cidrs
            ipv6_cidr_blocks = null
            prefix_list_ids = null
            security_groups = null
            self = null
        }

    ]

    egress = [
        {
            description = "Allow all egress"
            prefix_list_ids = null
            security_groups = null
            self = null
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }
    ]

    tags = var.common_tags
      
}