### Azure Arc — Kubernetes Connectivity Issue

**Issue:** Arc onboarding failed due to incorrect kubeconfig selection and DNS resolution.

**Root causes:**

- Azure CLI selected private AKS instead of on-prem Kubernetes.
- `k8-api.lab` couldn't resolve.
- An old kubeconfig pointed to an inactive localhost tunnel.

**Fix:**

1. Verified Tailscale connectivity to (on-prem control node1)`100.113.198.96:6443`.
2. Added `100.113.198.96 k8-api.lab` to Mac's `/etc/hosts`.
3. Flushed DNS cache and corrected kubeconfig to `https://k8-api.lab:6443`.
4. Confirmed connectivity with `kubectl get nodes`.

**Result:** On-prem Kubernetes API accessible from Mac and worker4.