# Phase 02 – EKS Cluster Creation with eksctl

## Overview

In this phase, we create a **production-ready Amazon EKS cluster** using `eksctl`, deployed **inside the custom VPC built in Phase 1**.  
The cluster is designed with **private worker nodes**, proper IAM configuration, and bash automation for repeatable operations.

This phase intentionally **does not use Terraform for EKS** to demonstrate real-world hybrid workflows where:
- Terraform handles foundational infrastructure (VPC, networking, state)
- `eksctl` handles Kubernetes cluster lifecycle

---

## Architecture Summary

- Existing VPC from Phase 1 (Terraform-managed)
- Private subnets across multiple Availability Zones
- EKS control plane (AWS-managed)
- Managed Node Group:
  - Runs in private subnets
  - No public IPs
- NAT Gateway used for outbound internet access
- Local access via `kubectl`
- Bash scripts for cluster lifecycle automation

---

## Prerequisites
- eksctl installed
- kubectl installed

## Step 1: eksctl Cluster Configuration
- Update the cluster.yaml file with your vpc id and private subnet ids (terraform outputs or aws management console)

## Step 2: Bash Automation Scripts
- Make scripts executable (run in day 2 root folder)
``` bash
chmod +x scripts/*.sh
```

## Step 3 - create eksctl cluster
``` bash
cd scripts
./create-cluster.sh
```

## Step 4 - Configure kubectl access
``` bash
./update-kubeconfig.sh
```
- This updates ~/.kube/config

## Step 5 -  Verify the cluster
``` bash
kubectl cluster-info
kubectl get nodes
```

## Step 6 - Clean up when done (cost control)
``` bash
./delete-cluster.sh
```
