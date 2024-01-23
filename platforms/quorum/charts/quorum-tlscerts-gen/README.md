[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# quorum-tlscerts-gen
This chart is a component of Hyperledger Bevel. Generates SSL/TLS certificates using OpenSSL, including a root CA certificate and node certificates, and storing them in a Vault server. These certificates enable secure communication and authentication between servers and clients in a system.. See [Bevel documentation](https://hyperledger-bevel.readthedocs.io/en/latest/) for details.

## TL;DR

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install tlscerts-gen bevel/quorum-tlscerts-gen
```

## Prerequisitess

- Kubernetes 1.19+
- Helm 3.2.0+

If Hashicorp Vault is used, then
- HashiCorp Vault Server 1.13.1+

> **Important**: Also check the dependent charts.

## Installing the Chart

To install the chart with the release name `tlscerts-gen`:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install tlscerts-gen bevel/quorum-tlscerts-gen
```

The command deploys the chart on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `tlscerts-gen` deployment:

```bash
helm uninstall tlscerts-gen
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
---

### global

| Name | Description | Default Value |
|-|-|-|
| `global.vault.type` | Type of Vault to support other providers. Currently, only `hashicorp` and `kubernetes` is supported | `hashicorp` |
| `global.vault.address` | URL of the Vault server | `""` |
| `global.vault.role` | Role used for authentication with Vault | `vault-role` |
| `global.vault.authPath` | Authentication path for Vault | `quorumNode` |
| `global.vault.serviceAccountName` | Serviceaccount name that will be created for Vault Auth and k8S Secret management | `vault-auth` |
| `global.vault.secretPrefix` | The value for vault secret prefix which must start with `data/` | `data/quorumNode` |

### name

| Name | Description | Default Value |
|-|-|-|
| `name` | Provide the name of the node | `node` |

### image

| Name | Description | Default Value   |
|-|-|-|
| `image.initContainerName` | Alpine-utils as base image with curl package already installed | `ghcr.io/hyperledger/bevel-alpine:latest` |
| `image.certsContainerName` | Image for the certs container | `ghcr.io/hyperledger/bevel-build:jdk8-latest` |
| `image.imagePullSecret` | Docker-registry secret stored in kubernetes cluster as a secret | `regcred` |
| `image.pullPolicy` | Pull policy to be used for the Docker image | `IfNotPresent` |


### subjects

| Name | Description | Default Value |
|-|-|-|
| `subjects.root_subject` | Mention the subject for rootca | `CN=DLT Root CA,OU=DLT,O=DLT,L=London,C=GB` |
| `subjects.cert_subject` | Mention the subject for cert | `CN=DLT Root CA/OU=DLT/O=DLT/L=London/C=GB` |

### opensslVars

| Name | Description | Default Value |
|-|-|-|
| `opensslVars.domain_name` | Domain name | "" |
| `opensslVars.domain_name_api` | Domain name for api endpoint | "" |
| `opensslVars.domain_name_web` | Domain name for web endpoint | "" |
| `opensslVars.domain_name_tessera` | Domain name for tessera endpoint | "" |
| `opensslVars.clientPort` | Transaction manager client port | 8888 |

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
