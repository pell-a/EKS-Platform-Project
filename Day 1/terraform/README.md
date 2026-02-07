# Phase 01 – Terraform VPC & Remote Backend

This phase sets up the **AWS networking foundation** and **Terraform remote backend** required for a production-ready EKS cluster.

---

## Prerequisites

Before starting, make sure the following are installed and configured:

- **AWS CLI**  
- **Terraform**  
- **Git**

Verify installations:

```bash
aws --version
terraform version
git --version
```
## Configure AWS Credentials
```bash
aws configure
```

## Step 1: Bootstrap Terraform Backend
Terraform requires the S3 bucket and DynamoDB table to exist before it can use the remote backend.
1. Navigate to the backend folder
```bash
cd bootstrap/
```
2. Initialize Terraform
```bash
terraform init
```
3. Review the execution plan
```bash
terraform plan
```
4. Apply backend resources
```bash
terraform apply
```

## Step 2: Configure Terraform Remote Backend
Reinitialize Terraform with the remote backend
```bash
terraform init
```

## Step 3: Provision VPC Infrastructure
1. Navigate to the VPC module
```bash
cd ../vpc
```
2. Initialize Terraform
```bash
terraform init
```
3. Apply
```bash
terraform apply
```

## Step 4: Verify Infrastructure in AWS Console
After apply completes, check that the following exist:
- VPC with correct CIDR
- Public and private subnets across multiple AZs
- NAT Gateway in a public subnet
- Route tables correctly associated
- S3 bucket for Terraform state
- DynamoDB table for state locking

Phase 1 done ✅





