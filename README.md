# Flask App Deployment (2-Tier DevOps Project)

This project demonstrates a complete **2-tier application deployment pipeline**
using **Flask + MySQL + Docker + Jenkins**.

It shows how a simple web application can be containerized, built using CI/CD,
and deployed automatically.

---

## Architecture

Frontend / App Layer:
- Flask application
- HTML template UI

Database Layer:
- MySQL container
- message table initialization

DevOps Stack:
- Docker
- Docker Compose
- Jenkins Pipeline

---

## Project Structure

.
├── app.py
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── requirements.txt
├── message.sql
└── templates/


Let's go throuh the steps:

First create your EC2 instance. Then you should start with the steps.

Step 1: Install all dependencies: Git | Docker | Docker-compose 

sudo apt-get update
sudo apt-get install git docker.io docker-compose-v2

Step 2: start and enable docker

sudo systemctl start docker
sudo systemctl enable docker

Step 3: add user to docker group(to run docker commands without sudo)

sudo usermod -aG docker $USER
newgrp docker

Step 4: instal Jenkins

First install Java:

sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version

Then Jenkins: you can get the command from Jenkins official website itself:

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins

Step 5: Start and enable Jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

Step 6: Let's run the container without jenkins to makesure all your images are build correctly

Your Dockerfile should look like this:

# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# install required packages for system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]
