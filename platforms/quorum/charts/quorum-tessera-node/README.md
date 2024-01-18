[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# Quorum Tessera Node Deployment


<!-- This [Helm chart](https://github.com/hyperledger/bevel/blob/develop/platforms/quorum/charts/quorum-tessera-node) helps to deploy tessera nodes. -->


<a name = "prerequisites"></a>
## Prerequisites
---
Before deploying the Helm chart, make sure to have the following prerequisites:

- Kubernetes cluster up and running.
- The GoQuorum network is set up and running.
- A HashiCorp Vault instance is set up and configured to use Kubernetes service account token-based authentication.
- The Vault is unsealed and initialized.
- Either HAproxy or Ambassador is required as ingress controller.
- Helm installed.


## Parameters
---

## Parameters
---

### replicaCount

| Name| Description | Default Value |
|-|-|-|
| `replicaCount`| Number of replicas | `1` |

### global

| Name | Description | Default Value |
|-|-|-|
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported | `hashicorp` |
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.secretEngine` | The value for vault secret engine name | `secretsv2` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.role` | Role used for authentication with Vault | `vault-role` |
| `global.vault.authPath` | Authentication path for Vault | `node` |
| `global.vault.secretPrefix` | The value for vault secret prefix which must start with `data/` | `data/node` |
| `global.vault.keyName` | Vault path where the keys are stored | `data/node/quorum` |
| `global.vault.tmSecretPath` | Vault path where the tm secrets are stored | `data/node/tm` |

### images

| Name | Description | Default Value |
|-|-|-|
| `images.alpineutils` | Valid image name and version to read certificates from vault server | ghcr.io/hyperledger/bevel-alpine:latest |
| `images.tessera` | Valid image name and version for quorum tessera | `quorumengineering/tessera:0.9.2` |
| `images.busybox` | Valid image name and version for busybox | `busybox` |
| `images.mysql` | Valid image name and version for MySQL. This is used as the DB for TM | `mysql/mysql-server:5.7` |

### node

| Name | Description | Default Value |
|-|-|-|
| `node.name` | Provide the name for Quorum node | `node` |
| `node.mountPath` | Mountpath for Quorum pod | `/etc/quorum/` |
| `node.imagePullSecret` | K8s secret name in the namespace | `regcred` |
| `node.serviceType` | k8s service type | `ClusterIP` |
| `node.ports.tm` | Tessera Transaction Manager service ports | `15013` |
| `node.ports.db` | DataBase port | `3306` |
| `node.dbName` | Mysql DB name | `demodb` |
| `node.mySqlUser` | Mysql username | `demouser` |


### tessera

| Name | Description | Default Value |
|-|-|-|
| `tessera.dbUrl` | Database URL | `jdbc:mysql://localhost:3306/demodb` |
| `tessera.dbUserName` | Database username | `demouser` |
| `tessera.url` | URL of the tessera node. This should be local. Use http if tls is OFF | `""` |
| `tessera.clienturl` | ############### | `""` |
| `tessera.otherNodes` | List of tessera nodes to connect in `url: <value>` format. This should be reachable from this node | `""` |
| `tessera.tls` | Provide if tessera will use tls. Supported values: `STRICT` & `OFF`| `STRICT` |
| `tessera.trust` | Server/client trust configuration for transaction manager nodes. Supported values: `WHITELIST`, `CA_OR_TOFU`, `CA`, `TOFU` | `TOFU` |

### proxy

| Name | Description | Default Value |
|-|-|-|
| `proxy.provider` | The proxy/ingress provider (ambassador, haproxy) | `ambassador` |
| `proxy.external_url` | External URL of the node | "" |
| `proxy.clientPort` | Expose a port publically via proxy | `""` |

### storage

| Name| Description | Default Value |
|-|-|-|
| `storage.storageClassName` | Kubernetes storage class for the node | `bevelStorageClass` |
| `storage.storageSize` | Memory for the node | `1Gi` |
| `storage.dbStorage` | Memory for database | `1Gi` |

<a name = "license"></a>
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
