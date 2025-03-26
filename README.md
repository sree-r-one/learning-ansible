# Terraform Azure Container Deployment

This project demonstrates how to deploy containerized applications to Azure using Terraform, Docker, and GitHub Actions. The architecture consists of a React frontend and Express backend deployed as container instances to Azure App Services.

## 🏗️ Architecture

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│                 │      │                 │      │                 │
│  GitHub Actions │ ──▶  │ Azure Container │ ──▶  │ Azure App       │
│  CI/CD Pipeline │      │ Registry (ACR)  │      │ Services        │
│                 │      │                 │      │                 │
└─────────────────┘      └─────────────────┘      └─────────────────┘
                                                          │
                                                          │
                                                          ▼
                                          ┌─────────────────────────────┐
                                          │                             │
                                          │  Frontend     Backend       │
                                          │  Container    Container     │
                                          │                             │
                                          └─────────────────────────────┘
```

## 🚀 Features

- **Infrastructure as Code**: Terraform configuration for Azure resources
- **Containerization**: Docker for both frontend and backend
- **CI/CD Pipeline**: GitHub Actions workflow for automated deployment
- **Conditional Resource Creation**: Terraform configuration to create or use existing resources
- **Local Development**: Docker Compose setup for local development

## 📋 Prerequisites

- Azure subscription and account
- Terraform CLI (v1.5.7+)
- Docker and Docker Compose
- Node.js (v18+)
- GitHub account (for CI/CD)

## 🛠️ Local Development

1. Clone the repository:

   ```
   git clone <repository-url>
   cd learning-terraform
   ```

2. Start the development environment:

   ```
   docker-compose up
   ```

3. Access the application:
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:3000/api

## 🌐 Project Structure

```
learning-terraform/
├── .github/workflows/    # GitHub Actions CI/CD pipeline
├── backend/              # Express.js API
│   ├── Dockerfile        # Production Docker image
│   ├── Dockerfile.dev    # Development Docker image
│   └── index.js          # Main server file
├── frontend/             # React + TypeScript frontend
│   ├── Dockerfile        # Production Docker image
│   ├── Dockerfile.dev    # Development Docker image
│   └── src/              # Application source code
├── terraform/            # Terraform IaC configuration
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Variable definitions
│   ├── outputs.tf        # Output definitions
│   └── terraform.tfvars  # Variable values
└── docker-compose.yml    # Local development setup
```

## ☁️ Deployment

### Manual Deployment

1. Build and push Docker images:

   ```
   docker build -t <acr-name>.azurecr.io/frontend:latest ./frontend
   docker build -t <acr-name>.azurecr.io/backend:latest ./backend
   docker push <acr-name>.azurecr.io/frontend:latest
   docker push <acr-name>.azurecr.io/backend:latest
   ```

2. Apply Terraform configuration:
   ```
   cd terraform
   terraform init
   terraform apply
   ```

### Automated Deployment

The project includes a GitHub Actions workflow that automatically:

1. Builds Docker images for frontend and backend
2. Pushes images to Azure Container Registry
3. Applies Terraform configuration to provision or update infrastructure
4. Restarts App Services to pick up the latest images

## ⚙️ Terraform Configuration

The Terraform configuration:

- Provisions or references an existing Azure Container Registry
- Creates or uses an existing App Service Plan
- Deploys frontend and backend containers as App Services
- Configures App Services to pull from the private container registry
- Outputs the deployed application URLs

## 🔑 Environment Variables

### Local Development

- `VITE_API_URL`: Backend API URL (set in docker-compose.yml)

### Production

- Frontend API URL is injected during the CI/CD process
- Sensitive information is stored in GitHub Secrets

## 🧪 Technologies Used

- **Frontend**: React, TypeScript, Vite
- **Backend**: Node.js, Express
- **Infrastructure**: Terraform, Azure
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Development**: Docker Compose
