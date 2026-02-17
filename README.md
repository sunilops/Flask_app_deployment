🚀 Flask App Deployment (2-Tier DevOps Project)

This project demonstrates a complete 2-Tier application deployment pipeline
using:

🐍 Flask

🗄 MySQL

🐳 Docker

🔁 Docker Compose

⚙ Jenkins (CI/CD)

☁ AWS EC2

It shows how a simple Flask application can be:

Containerized

Connected to a MySQL database

Built & deployed using Jenkins

Hosted on AWS EC2

🏗 Architecture
Application Layer

Flask Web Application

HTML Template UI

AJAX message submission

Database Layer

MySQL 5.7 container

Database initialization via message.sql

DevOps Stack

Docker

Docker Compose

Jenkins Pipeline

AWS EC2

📂 Project Structure
.
├── app.py
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── requirements.txt
├── message.sql
└── templates/

☁ AWS EC2 Setup Guide
Step 1: Launch EC2 Instance

Ubuntu Server

Allow ports: 22, 8080 (Jenkins), 5000 (Flask)

SSH into instance

Step 2: Install Dependencies
sudo apt-get update
sudo apt-get install -y git docker.io docker-compose-v2

Step 3: Enable Docker
sudo systemctl start docker
sudo systemctl enable docker


Add user to docker group:

sudo usermod -aG docker $USER
newgrp docker

⚙ Install Jenkins
Install Java
sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version

Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins


Start Jenkins:

sudo systemctl start jenkins
sudo systemctl enable jenkins

🐳 Docker Configuration
Dockerfile
FROM python:3.9-slim

WORKDIR /app

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

docker-compose.yml
version: "3.8"

services:
  mysql:
    image: mysql:5.7
    container_name: mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: devops
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    volumes:
      - ./mysql-data:/var/lib/mysql
      - ./message.sql:/docker-entrypoint-initdb.d/message.sql
    networks:
      - twotier
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uroot", "-proot"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 60s

  flask-app:
    build: .
    container_name: flask-app
    ports:
      - "5000:5000"
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASSWORD: root
      MYSQL_DB: devops
    depends_on:
      - mysql
    networks:
      - twotier
    restart: always

networks:
  twotier:

▶ Run Without Jenkins (Manual Test)
docker compose up -d


Check:

docker images
docker ps


If failed:

docker logs <container_name>


Access application:

http://<EC2-PUBLIC-IP>:5000

🔁 Jenkins Pipeline Setup
Unlock Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


Grant Docker permission:

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

Configure Jenkins

Go to: http://<EC2-IP>:8080

Add GitHub Credentials

Manage Jenkins → Credentials

Create New Pipeline

New Item → Pipeline

Select:

Pipeline script from SCM

Provide GitHub repo URL

Select credentials

Enable:

GitHub hook trigger

Build the pipeline and monitor console output.

🎯 CI/CD Flow

Developer pushes code to GitHub

Jenkins pulls latest code

Docker image is built

Containers are deployed

Application becomes live on AWS

🛠 Tech Stack

Python

Flask

MySQL

Docker

Docker Compose

Jenkins

AWS EC2

👨‍💻 Author

Sunil Kumar Panda
DevOps Engineer | AWS | Docker | Jenkins | Kubernetes

🎓 Learning Outcome

This project demonstrates:

Two-tier architecture

Containerization using Docker

CI/CD with Jenkins

Deployment on AWS EC2

MySQL integration with Flask
