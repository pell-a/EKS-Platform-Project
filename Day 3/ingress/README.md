# Day 3: EKS NGINX Apps with Ingress (ALB)

This guide walks through creating **NGINX apps** on EKS, setting up **path-based routing with AWS ALB**.

---

## 1️⃣ Prerequisites

- EKS cluster already created (free-tier 3 nodes + optional larger nodes for controller)
- AWS CLI configured
- kubectl installed and configured
- Helm installed

---

## 2️⃣ Steps

### Step 2.1: Enable OIDC for IAM Roles

```bash
eksctl utils associate-iam-oidc-provider \
  --cluster observability-eks \
  --approve
```

### Step 2.2: Create IAM Policy for AWS Load Balancer Controller
```bash
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam-policy.json
```

### Step 2.3: Create Service Account and Attach Policy
```bash
eksctl create iamserviceaccount \
  --cluster observability-eks \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

### Step 2.4: Install AWS Load Balancer Controller via Helm
``` bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=observability-eks \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=<YOUR_VPC_ID>
```

### Step 2.5: Create new nodegroup with a larger instance type
The instance type, t3.micro, in our current nodegroup, privateng, doesn't have enough resources for the next step. We will create a new nodegroup and delete the old one.
```bash
eksctl create nodegroup -f nodegroup-large.yaml
eksctl delete nodegroup --cluster observability-eks --name privateng
```

### Step 2.6: Apply Deployments, Services and Ingress
```bash
kubectl apply -f nginx-apps.yaml
kubectl apply -f nginx-services.yaml
kubectl apply -f nginx-ingress.yaml
```

### Step 2.7: Test your app
Run
```bash
kubectl get ingress
```
The address is your alb_dns
http://<ALB_DNS>/app1 → App1
http://<ALB_DNS>/app2 → App2