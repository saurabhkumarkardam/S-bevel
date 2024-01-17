[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# quorum-ibft-crypto-gen
This chart is a component of Hyperledger Bevel. The quorum-ibft-crypto-gen charts generates the crypto materials for ibft consensus only if they are not already available in the vault. See [Bevel documentation](https://hyperledger-bevel.readthedocs.io/en/latest/) for details.

## TL;DR

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install genesis bevel/besu-genesis
```

## Prerequisitess

- Kubernetes 1.19+
- Helm 3.2.0+

If Hashicorp Vault is used, then
- HashiCorp Vault Server 1.13.1+

> **Important**: Also check the dependent charts.

## Installing the Chart

To install the chart with the release name `ibft-crypto-gen`:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install ibft-crypto-gen bevel/quorum-ibft-crypto-gen
```

The command deploys the chart on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `ibft-crypto-gen` deployment:

```bash
helm uninstall ibft-crypto-gen
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters
These parameters are refered to as same in each parent or child chart
| Name | Description | Default Value |
|-|-|-|
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.role`| Role used for authentication with Vault | `vault-role` |
| `global.vault.authPath` | Authentication path for Vault | `supplychain` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.secretPrefix` | The value for vault secret engine name | `secretsv2` |
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported. | `hashicorp` |
| `global.vault.retries` | Number of retries to check contents from vault | `30` |
| `sleepTime` | Sleep time after every retry in seconds | `20` |

### Peer

| Name | Description | Default Value |
|-|-|-|
| `peer.name` | Name of the peer | `carrier` |
| `peer.gethPassphrase` | Passphrase for building the crypto files | `12345` |

### Image

| Name | Description | Default Value |
|-|-|-|
| `image.initContainerName` | Alpine utils image | `ghcr.io/hyperledger/bevel-alpine:latest` |
| `image.pullPolicy` | Pull policy to be used for the Docker image | `IfNotPresent` |
| `image.node` | Pull quorum Docker image | `quorumengineering/quorum:21.4.2` |

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
