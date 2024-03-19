#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -version
aws s3 cp s3://strongerbucket-s3s3/docker-compose.yml /tmp
cd /tmp
docker-compose up -d