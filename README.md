# Pawn Service CI/CD Infrastructure

This repository contains the CI/CD and deployment infrastructure for the Pawn Service project, including Jenkins pipelines, Nginx reverse proxy configuration, Cloudflare tunneling, and Stripe webhook integration.

## 🏗️ Architecture Overview

- **CI/CD Platform**: Jenkins (running in Docker)
- **Frontend**: ReactJS + npm (CI/CD via Jenkins)
- **Backend**: Spring Boot + Gradle (CI/CD via Jenkins)
- **Reverse Proxy**: Nginx (handling `api.baotrang.io.vn`, `jenkins.baotrang.io.vn`, etc.)
- **Public Access**: Cloudflare Tunnel (Tunneling local services to public domains)
- **Payment Integration**: Stripe CLI for webhook forwarding.

---

## 🚀 Getting Started

### 1. Prerequisites
- Docker & Docker Compose installed.
- Git installed.
- Cloudflare account (for tunneling).
- Stripe account (for payments).

### 2. Jenkins Setup (CI/CD)

Jenkins is configured to run inside a Docker container with access to the host's Docker socket to build images.

- **Start Jenkins**:
  ```bash
  cd jenkins
  docker-compose up -d
  ```
- **Access Jenkins**: Open `http://localhost:8000` (initially) or `http://jenkins.baotrang.io.vn` (once tunnel is up).
- **Required Jenkins Plugins**:
  - Docker Pipeline
  - NodeJS Plugin (v22.14.0 used in Frontend pipeline)
  - GitHub Integration
- **Post-Install Configuration**:
  - **Tool Setup**: Go to *Manage Jenkins > Global Tool Configuration* and add NodeJS `nodejs22.14.0`.
  - **Credentials**: Add `DOCKER_USER` and `DOCKER_PASS` as Jenkins credentials for Docker Hub access.

### 3. Nginx Reverse Proxy Setup

Nginx acts as the entry point for all incoming traffic through the Cloudflare tunnel.

- **Configuration**: Ensure `nginx/config/nginx.conf` correctly routes traffic to:
  - Backend: `http://backend-pawn-app:8080`
  - Frontend: `http://frontend-pawn-app:3000`
  - Jenkins: `http://jenkins:8080` (Internal container name)
- **Start Nginx**:
  ```bash
  cd nginx
  docker-compose up -d
  ```

### 4. Cloudflare Tunnel (Public Access)

Cloudflare Tunnel provides secure public access without opening firewall ports.

- **Authentication**:
  ```bash
  cloudflared tunnel login
  ```
- **Creation & DNS Routing**:
  Edit `cloudflare/register.sh` with your tunnel name and run it:
  ```bash
  bash cloudflare/register.sh
  ```
- **Running the Tunnel**:
  Update `cloudflare/config.yml` with your generated **Tunnel ID** and **Credentials Path**, then run:
  ```bash
  cloudflared --config cloudflare/config.yml tunnel run pawn-service
  ```

### 5. Stripe Webhook Integration

Forward Stripe payment events to your local/staging backend.

- **Setup**:
  Edit `stripe/register.sh` with your `sk_test_xxxxxx` key.
- **Listen**:
  ```bash
  bash stripe/register.sh
  ```

---

## 🛠️ Pipeline Details

### Backend Pipeline (`jenkins/backend/Jenkinsfile`)
1. **Checkout**: Pulls code from `maituananh/backend`.
2. **Build**: Runs `./gradlew clean build -x test`.
3. **Test**: Runs unit tests.
4. **Package**: Generates JAR file.
5. **Docker**: Builds image with timestamp tag and pushes to Docker Hub.
6. **Deploy**: Stops existing container and runs the new one on port 8080.

### Frontend Pipeline (`jenkins/frontend/Jenkinsfile`)
1. **Checkout**: Pulls code from `maituananh/pawn-service-fe`.
2. **Tools**: Uses NodeJS 22.14.0.
3. **Build**: Runs `npm install` and `npm run build`.
4. **Docker**: Builds image (usually Nginx-based) and pushes to Docker Hub.
5. **Deploy**: Serves the app on port 3000.

---

## 📝 Maintenance

- **Cleanup**: The pipelines automatically keep only the 3 latest Docker images locally to save disk space.
- **Monitoring**: Check Jenkins logs for build failures or Docker container statuses via `docker ps`.
