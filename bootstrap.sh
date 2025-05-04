#!/bin/bash

# Preinstalled Tools Docker, kubectl, Kind, Helm, Helm diff plugin

# Exit immediately if any command fails
set -e

# Define cluster name
CLUSTER_NAME="sreassign"

echo "Creating KIND cluster..."
kind create cluster --name "$CLUSTER_NAME" --config configs/kind-config.yaml

echo "Creating namespaces..."
kubectl apply -f configs/ns.yaml

echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

echo "Waiting for ingress controller to be ready..."


sleep 10

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD server deployment to be ready..."
kubectl wait --namespace argocd \
  --for=condition=available deployment/argocd-server \
  --timeout=180s

echo "Bootstrapping ArgoCD app for metrics-app..."
kubectl apply -f argocd/argo-app.yaml

echo "Setup complete. You can now port-forward ArgoCD UI with:"
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443 &"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo"
