#!/bin/bash
set -e

echo "Creating EKS cluster..."
eksctl create cluster -f ../cluster.yaml