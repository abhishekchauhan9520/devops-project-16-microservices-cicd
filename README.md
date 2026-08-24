# Project 16 — CI/CD Pipeline for Microservices (Docker + Kubernetes)

A small three-component microservices platform demonstrating container builds, health checks, Kubernetes deployments, and a GitHub Actions CI/CD workflow.

## Architecture

```text
Browser
  |
  v
Frontend (Nginx) --/service-a/--> Service A (Flask)
      |
      +---------/service-b/-----> Service B (Node/Express)
```

In Kubernetes, the frontend and both backend services run as Deployments behind ClusterIP Services. Nginx proxies `/service-a/` and `/service-b/` to the internal service names.

## Components

- `service-a/` — Python Flask API on port 5000
- `service-b/` — Node/Express API on port 6000
- `frontend/` — Nginx static frontend + reverse proxy on port 80
- `k8s/` — Deployments and Services
- `scripts/` — build/push and Kubernetes deployment helpers
- `tests/` — HTTP health checks
- `.github/workflows/ci-cd.yml` — validation, image build/push, and manual deployment

## CI/CD design

Pull requests run validation only. Pushes to `main` validate and build/push immutable images tagged with the Git commit SHA plus `latest`. Kubernetes deployment is deliberately manual via `workflow_dispatch` and requires a `KUBE_CONFIG_DATA` secret.

Required repository secrets:

- `DOCKER_REGISTRY` — full image namespace, e.g. `ghcr.io/OWNER/REPO`
- `DOCKER_REGISTRY_HOST` — registry host, e.g. `ghcr.io`
- `REGISTRY_USERNAME`
- `REGISTRY_TOKEN`
- `KUBE_CONFIG_DATA` — base64-encoded kubeconfig for the target cluster

## Local checks

Without Docker/Kubernetes, you can still run:

```bash
python -m py_compile service-a/app.py
node --check service-b/index.js
bash -n scripts/*.sh tests/*.sh
```

With Docker and Kubernetes available, build images with `scripts/build_and_push.sh` and deploy with `scripts/deploy_k8s.sh`.

## Security notes

Do not commit registry credentials, kubeconfig files, or cloud credentials. Use repository secrets or an external identity mechanism. Image tags based on commit SHA are preferred for reproducible deployments.
