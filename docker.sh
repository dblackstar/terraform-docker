#!/bin/bash

yum udpate -y

yum install -y docker
systemctl start docker
systemctl enable docker
usermd a- -G docker ec2-user

mkdir -p /home/ec2-user/docker-app
cd /home/ec2-user/docker-app

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

# Create Dockerfile
cat > Dockerfile << 'DOCKERFILE'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKERFILE

docker build -t devops-webapp .
DOCKERHUB_USERNAME = ${DOCKERHUB_USERNAME:-"millanstar"}
IMAGE_TAG="devops-terraform-docker-handson"
FULL_IMAGE_NAME="$DOCKERHUB_USERNAME/$IMAGE_TAG:latest"


docker tag devops-webapp $FULL_IMAGE_NAME

#logging an push to dockerhub




docker run -d -p 80:80 --name devops-container devops-webapp
chown -R ec2-user:ec2-user /home/ec2-user/docekr-app

sleep 15
