# 🚀 SRE Assignment: Metrics App Deployment

## 🧩 Objective

Deploy a containerized app that exposes a `/counter` endpoint using **Helm**, **ArgoCD** and **KIND**, and Observe the behavior of the `/counter` ,note any anomalies or inconsistent responses, document your debugging process.

---

## 📋 Requirements

- Docker
- kubectl
- KIND (Kubernetes in Docker)
- Helm, Helm Diff plugin


---

## 🗂️ Project Structure

```text
.
├── metrics-app/           # Helm chart for the app
├── argocd/
│   └── argo-app.yaml      # ArgoCD application manifest
├── kind/
│   └── kind-config.yaml   # KIND cluster config
├── bootstrap.sh           # Full cluster + app setup script
├── RCA.md                 # Root cause analysis and debugging
├── README.md              # This file
