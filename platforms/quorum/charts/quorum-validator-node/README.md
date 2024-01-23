[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# quorum-validator-node

This chart is a component of Hyperledger Bevel. Deploys a validator Quorum node. See [Bevel documentation](https://hyperledger-bevel.readthedocs.io/en/latest/) for details.

## TL;DR

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install validator-node bevel/quorum-validator-node
```

## Prerequisitess

- Kubernetes 1.19+
- Helm 3.2.0+

If Hashicorp Vault is used, then
- HashiCorp Vault Server 1.13.1+

> **Important**: Also check the dependent charts.

## Installing the Chart

To install the chart with the release name `validator-node`:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install validator-node bevel/quorum-validator-node
```

The command deploys the chart on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `validator-node` deployment:

```bash
helm uninstall validator-node
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
---

### replicaCount

| Name | Description | Default Value |
|-|-|-|
| `replicaCount` | Number of replicas | `1` |

### metadata

| Name | Description | Default Value |
|-|-|-|
| `metadata.labels` | Provide any additional labels | `""` |

### images

| Name | Description | Default Value |
|-|-|-|
| `images.node` | Valid image name and version for quorum node | `quorumengineering/quorum:2.1.1` |
| images.alpineutils | Valid image name and version to read certificates from vault server | `ghcr.io/hyperledger/bevel-alpine:latest` |

### node

| Name | Description | Default Value |
|-|-|-|
| `node.name` | Name for Quorum node | `node` |
| `node.status` | Status of the node as `default`, `additional` | `default` |
| `node.peer_id` | Id which is obtained when the new peer is added for raft consensus | `5` |
| `node.consensus` | Consesus for the Quorum network, values can be `raft` or `ibft` | `ibft` |
| `node.mountPath` | Mountpath for Quorum pod | `/etc/quorum/qdata` |
| `node.imagePullSecret` | Docker-registry secret stored in kubernetes cluster as a secret | `regcred` |
| `node.keyStore` | Keystore file name | `keystore` |
| `node.serviceType` | K8s service type | `ClusterIP` |
| `node.ports.rpc` | rpc service ports | `8546` |
| `node.ports.raft` | raft service ports | `50401` |
| `node.ports.quorum` | Quorum port | `21000` |

### vault

| Name | Description | Default Value |
|-|-|-|
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported | `hashicorp` |
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.role` | Role used for authentication with Vault | `vault-role` |
| `global.vault.authPath` | Authentication path for Vault | `quorumOrg` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.secretPrefix` | The value for vault secret prefix which must start with `data/` | `data/quorumOrg` |
| `global.vault.keyName` | Vault path where the keys are stored | `data/quorumOrg/quorum` |

### genesis

| Name | Description | Default Value |
|-|-|-|
| `genesis` | genesis.json file in base64 format | `""` |

### staticnodes

| Name | Description | Default Value |
|-|-|-|
| `staticNodes` | Static nodes as an array  | `""` |

### proxy

| Name | Description | Default Value |
|-|-|-|
| `proxy.provider` | The proxy/ingress provider (`ambassador`, `haproxy`) | `ambassador` |
| `proxy.external_url` | external URL for the node | `""` |
| `proxy.quorumPort` | The Quorum port exposed externally via the proxy | `15031` |
| `proxy.portRaft` | The Raft port exposed externally via the proxy | `15032` |

### storage

| Name | Description | Default Value |
|-|-|-|
| `storage.storageClassName` | The Kubernetes storage class for the  | `bevelStorageClass` |
| `storage.storageSize` | Memory for the node | `1Gi` |

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
