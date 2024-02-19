[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# Charts for Hyperledger Goquorum components

## About
This folder contains the helm charts which are used for the deployment of the Hyperledger Goquorum components. Each helm that you can use has the following keys and you need to set them. The `global.cluster.provider` is used as a key for the various cloud features enabled. Also you only need to specify one cloud provider, **not** both if deploying to cloud. As of writing this doc, AWS is fully supported.

```yaml
global:
  serviceAccountName: vault-auth
  cluster:
    provider: aws   # choose from: minikube | aws
    cloudNativeServices: false  # future: set to true to use Cloud Native Services 
    kubernetesUrl: "https://yourkubernetes.com" # Provide the k8s URL, ignore if not using Hashicorp Vault
  vault:
    type: hashicorp # choose from hashicorp | kubernetes
    network: quorum   # must be quorum for these charts
    # Following are necessary only when hashicorp vault is used.
    address: http://vault.url:8200
    authPath: supplychain
    secretEngine: secretsv2
    secretPrefix: "data/supplychain"
    role: vault-role
```

## Usage

### Pre-requisites

- Kubernetes Cluster (either Managed cloud option like EKS or local like minikube)
- Accessible and unsealed Hahsicorp Vault (if using Vault)
- Configured Ambassador AES (if using Ambassador as proxy)
- Update the dependencies
  ```
  helm dependency update quorum-genesis
  helm dependency update quorum-node
  ```


## `Without Proxy and Vault`

### 1. Create Namespace
```bash
kubectl create namespace carrier-quo
```

### 2. Install Genesis Node
```bash
# Install the genesis node
helm install genesis ./quorum-genesis --namespace supplychain-quo -f ./values/noproxy-and-novault/genesis.yaml
```

### 3. Install Validator Nodes
```bash
# Install validator nodes
helm install validator-1 ./quorum-node --namespace supplychain-quo -f ./values/noproxy-and-novault/validator.yaml
helm install validator-2 ./quorum-node --namespace supplychain-quo -f ./values/noproxy-and-novault/validator.yaml
helm install validator-3 ./quorum-node --namespace supplychain-quo -f ./values/noproxy-and-novault/validator.yaml
helm install validator-4 ./quorum-node --namespace supplychain-quo -f ./values/noproxy-and-novault/validator.yaml
```

### 4. Deploy Member and Tessera Node Pair
```bash
# Deploy Quorum and Tessera node pair
helm install member-1 ./quorum-node --namespace supplychain-quo -f ./values/noproxy-and-novault/txnode.yaml
```

### Setting Up Another Member in a Different Namespace

```bash
# Create a new namespace if it doesn't already exist
kubectl create namespace carrier-quo

# Copy configuration from existing namespace (supplychain-quo) to the new namespace (carrier-quo)
kubectl get configmap static-nodes-config -n supplychain-quo -o yaml | sed 's/namespace: supplychain-quo/namespace: carrier-quo/g' | kubectl apply -n carrier-quo -f -
kubectl get configmap genesis-config -n supplychain-quo -o yaml | sed 's/namespace: supplychain-quo/namespace: carrier-quo/g' | kubectl apply -n carrier-quo -f -

# Install secondary genesis node
helm install genesis ./quorum-genesis --namespace carrier-quo -f ./values/noproxy-and-novault/genesis-sec.yaml

# Install secondary member node
helm install member-2 ./quorum-node --namespace carrier-quo -f ./values/noproxy-and-novault/txnode-sec.yaml
```

---

## `With Ambassador Proxy and Vault`

### 1. Create Namespace and Vault Secret
```bash
# Create a namespace
kubectl create namespace supplychain-quo

# Create the roottoken secret
kubectl -n supplychain-quo create secret generic roottoken --from-literal=token=<VAULT_ROOT_TOKEN>
```

### 2. Install Genesis Node
```bash
# Install the genesis node
helm install genesis ./quorum-genesis --namespace supplychain-quo -f ./values/proxy-and-vault/genesis.yaml
```

### 3. Install Validator Nodes
```bash
# Install validator nodes
helm install validator-1 ./quorum-node --namespace supplychain-quo -f ./values/proxy-and-vault/validator.yaml --set global.proxy.p2p=15011
helm install validator-2 ./quorum-node --namespace supplychain-quo -f ./values/proxy-and-vault/validator.yaml --set global.proxy.p2p=15012
helm install validator-3 ./quorum-node --namespace supplychain-quo -f ./values/proxy-and-vault/validator.yaml --set global.proxy.p2p=15013
helm install validator-4 ./quorum-node --namespace supplychain-quo -f ./values/proxy-and-vault/validator.yaml --set global.proxy.p2p=15014
```

### 4. Deploy Member and Tessera Node Pair
```bash
# Deploy Quorum and Tessera node pair
helm install supplychain ./quorum-node --namespace supplychain-quo -f ./values/proxy-and-vault/txnode.yaml --set global.proxy.p2p=15015
```

### Setting Up Another Member in a Different Namespace

```bash
# Create a new namespace
kubectl create namespace carrier-quo

# Create the roottoken secret
kubectl -n carrier-quo create secret generic roottoken --from-literal=token=<VAULT_ROOT_TOKEN>

# Copy configuration from existing namespace (supplychain-quo) to the new namespace (carrier-quo)
kubectl get configmap static-nodes-config -n supplychain-quo -o yaml | sed 's/namespace: supplychain-quo/namespace: carrier-quo/g' | kubectl apply -n carrier-quo -f -
kubectl get configmap genesis-config -n supplychain-quo -o yaml | sed 's/namespace: supplychain-quo/namespace: carrier-quo/g' | kubectl apply -n carrier-quo -f -

# Install secondary genesis node
helm install genesis ./quorum-genesis --namespace carrier-quo -f ./values/proxy-and-vault/genesis-sec.yaml

# Install secondary member node
helm install carrier ./quorum-node --namespace carrier-quo -f ./values/proxy-and-vault/txnode-sec.yaml --set global.proxy.p2p=15016
```

## `API Calls`

Once deployed, services are available as follows on the address provided in your `global.proxy.externalUrlSuffix`.

```bash
# HTTP RPC API
curl -v -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' http://supplychainrpc.test.yourdomain.com

# This should return (confirming that the node running the JSON-RPC service is syncing):
{
  "jsonrpc" : "2.0",
  "id" : 1,
  "result" : "0x64"
}
```

## `Clean-up`

To clean up, simply uninstall the Helm releases. It's important to uninstall the genesis Helm chart at the end to prevent any cleanup failure.

```bash
helm uninstall --namespace supplychain-quo validator-1
helm uninstall --namespace supplychain-quo validator-2
helm uninstall --namespace supplychain-quo validator-3
helm uninstall --namespace supplychain-quo validator-4
helm uninstall --namespace supplychain-quo supplychain
helm uninstall --namespace supplychain-quo genesis

helm uninstall --namespace carrier-quo carrier
helm uninstall --namespace carrier-quo genesis
```

## License

This chart is licensed under the Apache v2.0 license.

Copyright &copy; 2023 Accenture

### Attribution

This chart is adapted from the [charts](https://hyperledger.github.io/bevel/) which is licensed under the Apache v2.0 License which is reproduced here:

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
