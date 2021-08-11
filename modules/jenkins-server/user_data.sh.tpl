#!/bin/bash

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo amazon-linux-extras install -y java-openjdk11
sudo yum -y update
sudo yum install -y jenkins iptables-services
sudo systemctl enable iptables
sudo systemctl start iptables
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport ${jenkins_port} -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport ${jenkins_port} -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 8080 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -t nat -I PREROUTING -p tcp --dport ${jenkins_port} -j REDIRECT --to-port 8080
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
sudo service iptables save
sudo systemctl daemon-reload
sudo systemctl start jenkins