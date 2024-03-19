#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 796347764150.dkr.ecr.eu-west-2.amazonaws.com
docker run -d --name new-major -p 80:80 796347764150.dkr.ecr.eu-west-2.amazonaws.com/major-demo-repo/major-app:latest