# DevOps Assignment

## Overview

This project demonstrates a local DevOps environment using:

- Terraform
- LocalStack (fake AWS)
- Docker
- Python
- GitHub Actions

The infrastructure is provisioned locally without using a real AWS account.

The project also includes a Python-based “Cost Janitor” tool that generates orphan-resource reports.

---

## How to run locally

### 1. Start LocalStack

```bash
docker run --rm -d -p 4566:4566 --name localstack localstack/localstack
```

Verify:

```bash
docker ps
```

---

### 2. Initialize Terraform

```bash
cd terraform
tflocal init
```

---

### 3. Format Terraform

```bash
tflocal fmt
```

---

### 4. Validate Terraform

```bash
tflocal validate
```

---

### 5. Apply Infrastructure

```bash
tflocal apply -auto-approve
```

This creates:
- VPC
- Public subnets
- Security group
- S3 bucket

inside LocalStack.

---

### 6. Run Janitor Report

```bash
cd ../janitor
python janitor.py
```

Expected output:

```text
Report generated
```

Generated files:
- report.json
- report.md

---

## Architecture

Project structure:

```text
devops-assignment/
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       └── network/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
├── janitor/
│   ├── janitor.py
│   ├── report.json
│   └── report.md
│
├── docs/
├── samples/
│
├── .github/
│   └── workflows/
│       └── cost-janitor.yml
│
└── README.md
```

### Components

#### Terraform
Used to provision fake AWS infrastructure locally using LocalStack.

#### LocalStack
Provides a local AWS-compatible environment.

#### Python Janitor
Simulates cloud cost optimization reporting.

#### GitHub Actions
Automates:
- Terraform setup
- Infrastructure provisioning
- Janitor execution

---

## Decisions & deviations

- Used LocalStack instead of real AWS to avoid cloud costs.
- Used modular Terraform structure for maintainability.
- Kept the Python janitor intentionally simple for demonstration purposes.
- Used GitHub Actions for CI automation.

---

## Trade-offs

- Infrastructure is simplified and not production-grade.
- No real AWS authentication or IAM setup.
- Limited monitoring and logging.
- Static sample orphan-resource report instead of live cloud scanning.

---

## AI usage disclosure

AI tools were used for:
- Troubleshooting installation/setup issues
- Understanding Terraform and LocalStack concepts
- Generating documentation guidance
- Learning GitHub Actions workflow syntax

All code and configurations were reviewed, modified, and tested manually.