#!/bin/bash
set -e

echo "Deleting EKS cluster..."
eksctl delete cluster -f ../cluster.yaml