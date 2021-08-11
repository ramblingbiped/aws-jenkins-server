output "jenkins_public_ip" {
    description = "Jenkins instance public ip address"
    value = aws_instance.jenkins-server.public_ip
}