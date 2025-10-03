#!/bin/bash

#Update OS
yum update -y

#Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

#Create app directory
mkdir -p /home/ec2-user/docker-app
cd /home/ec2-user/docker-app

#Create HTML file
cat > index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform DevOps</title>
</head>
<body>
    <h1>'This is DevOps Terraform and Docker HandsOn'.</h1>
</body>
</html>
HTML

# Create Dockerfile using NGINX as base image
cat > Dockerfile << 'DOCKERFILE'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKERFILE

#Dockerhub credentials
DOCKERHUB_USERNAME="${dockerhub_username}"
DOCKERHUB_PASSWORD="${dockerhub_password}"
IMAGE_TAG="devops-terraform-docker"
FULL_IMAGE_NAME="$DOCKERHUB_USERNAME/$IMAGE_TAG:1atest"

#Build the Docker image
docker build -t devops-webapp

#Tag the image for DockerHub
docker tag devops-webapp $FULL_IMAGE_NAME

#Login to DockerHub and push the image 
docker login -u "$DOCKERHUB_USERNAME" --password-stdin
docker push $FULL IMAGE_NAME

#Run the container
docker -p 80:80 --name devops-container --restart unless-stopped devops-webapp
chown -R ec2-user:ec2-user /home/ec2-user/docker-app


