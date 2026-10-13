# Stock Management System — DevOps Project

A production-simulated DevOps project focused on containerization, Infrastructure as Code, CI/CD automation, and Kubernetes deployment.

## Project Overview

The Stock Management System uses a simplified Nginx static frontend to practice real-world DevOps workflows across local Kubernetes infrastructure and AWS.

### Technology Stack

- **Nginx** — Serves the static HTML frontend.
- **Docker** — Packages the frontend into a container image.
- **Kubernetes & Kind** — Runs the application on a local Kubernetes cluster.
- **Terraform** — Defines and manages infrastructure as code.
- **GitHub Actions** — Automates CI/CD workflows.
- **Docker Hub** — Stores and distributes the frontend image.
- **AWS EC2** — Hosts the frontend on a cloud-based virtual server.
- **AWS IAM & GitHub OIDC** — Supports identity-based access for automated AWS deployment.

## Deployment Environments

### Local Kubernetes

The frontend runs on a local Kubernetes cluster created with Kind and managed through Terraform.

**Status:** Operational

### AWS EC2

The Nginx frontend runs in a Docker container on an AWS EC2 instance.

**Application URL:** http://16.170.20.174/

**Status:** Operational

> The application currently uses HTTP. HTTPS configuration and TLS validation have not yet been verified.

## CI/CD Pipeline

The project uses GitHub Actions to automate frontend image delivery:

1. A code change is pushed to the `main` branch.
2. The CI workflow builds the Docker image.
3. The image is pushed to Docker Hub.
4. The CD workflow runs after successful completion of CI.
5. GitHub Actions uses AWS OIDC to request temporary AWS credentials for the deployment role.

## Infrastructure as Code

Terraform manages the AWS infrastructure, including:

- VPC and public subnet
- Internet Gateway and route table
- EC2 instance and Elastic IP
- Security Group
- SSH key pair

The local Kubernetes environment is also part of the project's infrastructure-as-code learning workflow.

## Current Project Status

- [x] Nginx frontend containerized with Docker
- [x] Frontend image published to Docker Hub
- [x] Local Kubernetes deployment using Kind
- [x] AWS EC2 frontend deployment
- [x] AWS networking and Security Group inspection
- [x] SSH connectivity verified
- [x] HTTP endpoint verified with `200 OK`
- [x] CI workflow successfully builds and publishes the frontend image
- [ ] Complete systematic AWS infrastructure and CI/CD debugging
- [ ] Migrate the workload to Amazon EKS
- [ ] Validate Kubernetes networking and ingress on EKS
- [ ] Configure and verify HTTPS

## Learning Objectives

This project develops practical skills in:

- Linux administration and troubleshooting
- Docker and container networking
- Kubernetes workloads, Services, and Ingress
- Terraform infrastructure management
- GitHub Actions CI/CD automation
- AWS networking, IAM, and security
- Production-style diagnosis: symptom → evidence → root cause → fix → retest

## Future Direction

The next milestone is to complete the AWS infrastructure and pipeline debugging process, then migrate the workload from the current EC2 deployment to Amazon EKS.

**Overall status:** Local Kubernetes and AWS EC2 frontend deployments are operational; EKS migration is pending.
