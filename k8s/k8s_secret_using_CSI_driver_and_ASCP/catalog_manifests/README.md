# Step-01: Add Helm Repositories
# Add Helm Repositories
`helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts`
`helm repo add aws-secrets-manager https://aws.github.io/secrets-store-csi-driver-provider-aws`
`helm repo update`

# List Helm Repos
`helm repo list`

# Step-02: Install the Secrets Store CSI Driver
# Install the Secrets Store CSI Driver in the kube-system namespace:
```
helm install csi-secrets-store \
  secrets-store-csi-driver/secrets-store-csi-driver \
  --namespace kube-system \
  --set tokenRequests[0].audience="pods.eks.amazonaws.com" \
  --set enableSecretRotation=true  \
  --set syncSecret.enabled=true \
  --set enablePodIdentity=true
```


# List all Helm releases across namespaces:
`helm list --all-namespaces`

# List releases only in the kube-system namespace:
`helm list -n kube-system`

# Verify installation status, pods, and resources created by the release:
`helm status csi-secrets-store -n kube-system`


# Verify pods:
`kubectl get pods -n kube-system -l app=secrets-store-csi-driver`

# Step-03: Install the AWS Secrets and Configuration Provider (ASCP)
# Install the AWS Secrets Manager CSI Driver Provider in the kube-system namespace.
```

helm install secrets-provider-aws \
  aws-secrets-manager/secrets-store-csi-driver-provider-aws \
  --namespace kube-system \
  --set secrets-store-csi-driver.install=false
```
# List installed Helm Releases
`helm list -n kube-system`

# Inspect the AWS provider Helm release:
`helm status secrets-provider-aws -n kube-system`

# Step-04: Create IAM Role, Policy and EKS Pod Identity Association

# Step-04-01: Create IAM Policy and Role for Pod Identity (AWS Secrets Manager Access)

```
export AWS_REGION="us-east-1"
export EKS_CLUSTER_NAME="reatil-cluster-dev"
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
```