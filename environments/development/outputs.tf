output "jenkins_ip" {
  description = "Public IP address of the Jenkins EC2 instance"
  value       = module.jenkins-server.jenkins_public_ip
}