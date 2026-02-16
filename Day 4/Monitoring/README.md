# Day 5: Monitoring with Prometheus and Grafana

This guide walks through deploying Prometheus and Grafana on an EKS cluster, using Helm, configured for minimal resource usage suitable for AWS free-tier instances.

---

## Steps
1. Add Helm Repositories

``` bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

2. Install kube-prometheus-stack and check pods

``` bash
helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace
kubectl get pods -n monitoring
```

3. Expose Grafana (temporary access)
 Instead of creating another LoadBalancer, we’ll port-forward.
``` bash
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring
```
Now open http://localhost:3000

4. Login to Grafana
Get the password with:
``` bash
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
```
The username is admin

5. Verify Prometheus is working
``` bash
kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090 -n monitoring
```
Open http://localhost:9090 and try the up query. You should see metrics.

6. View Kubenertes metrics in Grafana
Go to dashboards in Grafana, You should already see preloaded dashboards like Kubernetes / Compute Resources / Node and Kubernetes / Compute Resources / Pod. No manual setup required.