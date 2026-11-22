# Azure Arc — Hybrid Kubernetes Runbook

**Purpose:** Manage on-prem kubeadm Kubernetes alongside AKS through Azure Arc.

**Azure:** `sub-mavencrest-management` / `rg-arc-kubernetes`  
**Cluster:** `arc-mavencrest-onprem`

### 1. Verify Kubernetes (Mac)

```
kubectl --kubeconfig ~/.kube/onprem-admin.conf get nodes
```

DNS fix if needed: Add `100.113.198.96 k8-api.lab` to `/etc/hosts`.

### 2. Prepare Azure (worker4 — AMD64)

```
export KUBECONFIG="$HOME/arc-onprem.conf"
az extension add --name connectedk8s --upgrade
az login
az account set --subscription sub-mavencrest-management
```

Register providers once per subscription: `Microsoft.Kubernetes`, `Microsoft.KubernetesConfiguration`, `Microsoft.ExtendedLocation`.

### 3. Connect Azure Arc (worker4)

```
az group create -n rg-arc-kubernetes -l eastus

az connectedk8s connect \
  -n arc-mavencrest-onprem \
  -g rg-arc-kubernetes \
  -l eastus
```

### 4. Verify

```
kubectl get pods -n azure-arc
az connectedk8s show -n arc-mavencrest-onprem \
  -g rg-arc-kubernetes \
  --query connectivityStatus -o tsv
```

**Expected:** `Connected`

**Next:** Flux GitOps, Azure Policy, monitoring.

**Note:** Arc agents use outbound HTTPS 443; no Azure VPN required for basic onboarding.