[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# RAFT Crypto GoQuorum Deployment

---
<!-- This [Helm chart](https://github.com/hyperledger/bevel/blob/develop/platforms/quorum/charts/quorum-tessera-key-mgmt) helps in generating Tessera crypto. -->

This chart is a component of Hyperledger Bevel. Generates certificates and keys required by Tessera transaction manager.. See [Bevel documentation](https://hyperledger-bevel.readthedocs.io/en/latest/) for details.

## TL;DR

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install tessera-key-mgmt bevel/quorum-tessera-key-mgmt
```

## Prerequisitess

- Kubernetes 1.19+
- Helm 3.2.0+

If Hashicorp Vault is used, then
- HashiCorp Vault Server 1.13.1+

> **Important**: Also check the dependent charts.

## Installing the Chart

To install the chart with the release name `tessera-key-mgmt`:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install tessera-key-mgmt bevel/quorum-tessera-key-mgmt
```

The command deploys the chart on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `tessera-key-mgmt` deployment:

```bash
helm uninstall tessera-key-mgmt
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
---

### global

| Name | Description | Default Value |
|-|-|-|
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported | `hashicorp` |
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.secretEngine` | The value for vault secret engine name | `secretsv2` |
| `global.vault.authPath` | Authentication path for Vault | `supplychain` |
| `global.vault.role` |  Role used for authentication with Vault | `vault-role` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.tmPrefix` | Vault path where the tm secrets are stored | `node/node/tm` |
| `global.vault.keyPrefix` | Vault path where the keys are stored | `node/node/key` |

### peer

| Name| Description | Default  |
|-|-|-|
| `peer.name` | Name of the peer | `node` |

### image

| Name | Description | Default Value |
|-|-|-|
| `image.repository` | Image repository for the indy-key-mgmt container | `quorumengineering/tessera:hashicorp-21.7.3` |
| `image.pullSecret` | Pull policy to be used for the Docker image | `regcred` |

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
