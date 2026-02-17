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


