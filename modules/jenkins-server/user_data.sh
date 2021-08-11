#!/bin/bash

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo amazon-linux-extras install -y java-openjdk11
sudo yum -y update
sudo yum install -y jenkins 
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo sed -i 's/JENKINS_PORT="8080"/JENKINS_PORT="80"/g' /etc/sysconfig/jenkins
sudo systemctl restart jenkins
sudo cat /etc/sysconfig/jenkins