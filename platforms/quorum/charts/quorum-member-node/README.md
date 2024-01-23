[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)


# bevel/quorum-member-node
This chart is a component of Hyperledger Bevel. The chart deploys an Quorum member (non-validator) node with or without the integration of Tessera transaction manager. See [Bevel documentation](https://hyperledger-bevel.readthedocs.io/en/latest/) for details.

## TL;DR

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install member-node bevel/quorum-member-node
```

## Prerequisitess

- Kubernetes 1.19+
- Helm 3.2.0+

If Hashicorp Vault is used, then
- HashiCorp Vault Server 1.13.1+

> **Important**: Also check the dependent charts.

## Installing the Chart

To install the chart with the release name `member-node`:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install member-node bevel/quorum-member-node
```

The command deploys the chart on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `member-node` deployment:

```bash
helm uninstall member-node
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
---

### replicaCount

| Name | Description | Default Value |
|-|-|-|
| `replicaCount` | Number of replicas | `1` |

### Global parameters
These parameters are refered to as same in each parent or child chart
| Name | Description | Default Value |
|-|-|-|
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported. | `hashicorp` |
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.secretPrefix` | The value for vault secret prefix which must start with `data/` | `data/node` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.keyName` | key name from where quorum secrets will be read | `quorum` |
| `global.vault.tm_keyName` | key name from where transaction-manager secrets will be read | `tm` |
| `global.vault.role` | Role used for authentication with Vault | `vault-role` |
| `global.vault.authPath` | Authentication path for Vault | `node` |

### image

| Name | Description | Default Value |
|-|-|-|
| `image.node` | Valid image name and version for quorum node | `quorumengineering/quorum:2.1.1` |
| `image.alpineutils` | Valid image name and version to read certificates from vault server | `ghcr.io/hyperledger/bevel-alpine:latest` |
<!-- | `image.tessera` | Valid image name and version for quorum tessera | `quorumengineering/tessera:0.9.2` | -->
<!-- | `image.busybox` | Valid image name and version for busybox | `busybox` | -->
<!-- | `image.mysql` | Valid image name and version for MySQL. This is used as the DB for TM | `mysql/mysql-server:5.7` | -->

### node

| Name | Description | Default Value |
|-|-|-|
| `node.name` | Name for Quorum node | `node` |
| `node.status` | Status of the node as default,additional | `default` |
| `node.peer_id` | Id which is obtained when the new peer is added for raft consensus | `5` |
| `node.consensus` | Consesus for the Quorum network, values can be 'raft' or 'ibft' | `ibft` |
| `node.mountPath` | mountpath for Quorum pod | `/etc/quorum/qdata` |
| `node.imagePullSecret` | Docker secret name in the namespace | `regcred` |
| `node.keyStore` | keystore file name | `keystore_1` |
| `node.serviceType` | K8s service type | `ClusterIP` |
| `node.ports.rpc` | Rpc service ports | `8546` |
| `node.ports.raft` | Raft service ports | `50401` |
<!-- | `node.ports.tm` | Tessera Transaction Manager service ports | `15013` | -->
| `node.ports.quorum` | Quorum port | `21000` |
<!-- | `node.ports.db` | DataBase port | `3306` | -->
<!-- | `node.dbName` | Mysql DB name | `demodb` | -->
<!-- | `node.mysqlUser` | Mysql username | `demouser` | -->
<!-- | `node.mysqlPassword` | Mysql user password |  | -->

### tm

| Name | Description | Default Value |
|-|-|-|
| `tm.type` |  | `none` |

### tessera

| Name | Description | Default Value |
|-|-|-|
<!-- | `tessera.dbUrl` | Database URL | `jdbc:mysql://localhost:3306/demodb` | -->
<!-- | `tessera.dbUsername` | Database username | `demouser` | -->
<!-- | `tessera.dbPassword` | Database password | `""` | -->
| `tessera.url` | Tessera node's own url. This should be local. Use http if tls is OFF | `""` |
| `tessera.clienturl` |  | `""` |
<!-- | `tessera.othernodes` | List of tessera nodes to connect in `url: <value>` format. This should be reachable from this node | `""` | -->
<!-- | `tessera.tls` | If tessera will use tls | `STRICT` | -->
<!-- | `tessera.trust` | Server/client trust configuration for transaction manager nodes | `TOFU` | -->


### genesis

| Name | Description | Default Value |
|-|-|-|
| `genesis` | genesis.json file in base64 format | `""` |


### staticnodes

| Name | Description | Default Value |
|-|-|-|
| `staticNodes` | Provide the static nodes as an array  | `""` |

### proxy

| Name | Description | Default Value |
|-|-|-|
| `proxy.provider` | The proxy/ingress provider (ambassador, haproxy) | `ambassador` |
| `proxy.external_url` | This field contains the external URL of the node | `""` |
<!-- | `proxy.portTM` | The TM port exposed externally via the proxy | `15013` | -->
<!-- | `proxy.rpcPort` | The RPC port exposed externally via the proxy | `15030` | -->
| `proxy.quorumPort` | The Quorum port exposed externally via the proxy | `15031` |
| `proxy.portRaft` | The Raft port exposed externally via the proxy | `15032` |

### storage

| Name | Description | Default Value |
|-|-|-|
| `storage.storageClassName` | The Kubernetes storage class for the node | `awsstorageclass` |
| `storage.storageSize` | The memory for the node | `1Gi` |
| `storage.dbStorage` | Provide the memory for database | `1Gi` |

### settings

| Name | Description | Default Value |
|-|-|-|
| `settings.removeGenesisOnDelete` |  | `true` |

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
