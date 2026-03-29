# Microservice Application Deployment

##  Overview

Deployed  microservices-based application using:

* Docker 
* Helm (Kubernetes packaging)
* Kubernetes (k3d cluster)
* Terraform (infrastructure provisioning)
* ArgoCD (GitOps deployment apps of apps)
* GitHub Actions (CI pipeline)
* Stakater Reloader (auto-restart on config changes)

---

## Application Architecture

The application consists of the following microservices:

### 1. Quotes Service

* Backend service (Python)
* Exposes: 5000
* Provides quote data

### 2. API Gateway

* Node.js service
* Exposes: 3000
* Communicates with Quotes service via:

  ```
  http://quotes:5000
  ```

### 3. Frontend

* UI application
* Exposes: `80`
* Communicates with API service

---

## Implementation Approach

### Step 1: Code Analysis

* Analyzed Dockerfiles for all services
* Reviewed docker-compose.yml to understand:

  * Service dependencies
  * Ports
  * Environment variables

---

### Step 2: Containerization

* Built Docker images for:

  * Quotes
  * API
  * Frontend
* Pushed images to DockerHub using github CI : https://hub.docker.com/repositories/sharjeel206


---

### Step 3: Helm Chart Creation

Used:

```bash
helm create quotes
helm create api
helm create frontend
```

Then customized each chart:

---

## Helm Chart Features

Each microservice includes:

### Deployment

* Configurable replicas
* Resource limits (CPU/Memory)
* Pod anti-affinity for distribution

### Service

* ClusterIP for internal services
* LoadBalancer for frontend (if required)

### ConfigMap

* Used for API service 

---

### Probes (Health Checks for API Health)

```yaml
probes:
  liveness:
    path: /api/status
    initialDelaySeconds: 10
  readiness:
    path: /api/status
    initialDelaySeconds: 5

```

---

### Horizontal Pod Autoscaler (HPA)

* Implemented for:

  * API
  * Frontend

* Based on CPU utilization:

  ```yaml
  averageUtilization: 70
  ```

---

### Pod Distribution

Used **podAntiAffinity**:

* Ensures pods are distributed across nodes
* Improves availability and resilience

---


