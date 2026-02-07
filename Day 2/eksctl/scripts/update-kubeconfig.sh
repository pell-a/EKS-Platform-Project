#!/bin/bash
set -e

aws eks update-kubeconfig \
  --region us-east-1 \
  --name observability-eks