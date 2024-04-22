[//]: # (##############################################################################################)
[//]: # (Copyright Accenture. All Rights Reserved.)
[//]: # (SPDX-License-Identifier: Apache-2.0)
[//]: # (##############################################################################################)

# substrate-genesis

This Helm chart performs two tasks as follows:
1. Generates keys for the specified number of nodes using the `dscp-node` CLI tool. The generated keys will be stored as Kubernetes secrets. If HashiCorp Vault is enabled, the keys will also be saved to HashiCorp Vault.
2. Generates a customized Genesis with the information provided by the user via the values.yaml of the same chart.

## TL;DR

```console
$ helm repo add bevel https://digicatapult.github.io/helm-charts
$ helm install genesis bevel/substrate-genesis
```

### Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

If HashiCorp Vault is utilized, ensure:
- HashiCorp Vault Server 1.13.1+

> **Note**: Verify the dependent charts for additional prerequisites.

### Installation

To install the chart with the release name `genesis`, execute:

```bash
helm repo add bevel https://hyperledger.github.io/bevel
helm install genesis bevel/substrate-genesis
```

This command deploys the chart onto the Kubernetes cluster using default configurations. Refer to the [Parameters](#parameters) section for customizable options.

> **Tip**: Utilize `helm list` to list all releases.

### Uninstallation

To remove the `genesis` deployment, use:

```bash
helm uninstall genesis
```

This command eliminates all Kubernetes components associated with the chart and deletes the release.

## Parameters

#### Global Parameters
These parameters remain consistent across parent or child charts.

| Name   | Description  | Default Value |
|--------|---------|-------------|
| `global.serviceAccountName` | Name of the service account for Vault Auth and Kubernetes Secret management | `vault-auth` |
| `global.cluster.provider` | Kubernetes cluster provider (e.g., AWS EKS, minikube). Currently tested with `aws` and `minikube`. | `aws` |
| `global.cluster.cloudNativeServices` | Future implementation for utilizing Cloud Native Services (`true` for SecretsManager and IAM for AWS; KeyVault & Managed Identities for Azure). | `false`  |
| `global.cluster.kubernetesUrl` | URL of the Kubernetes Cluster  | `""`  |
| `global.vault.type`  | Vault type support for other providers. Currently supports `hashicorp` and `kubernetes`. | `hashicorp` |
| `global.vault.role`  | Role used for authentication with Vault | `vault-role` |
| `global.vault.network`  | Deployed network type | `substrate` |
| `global.vault.address`| URL of the Vault server.    | `""` |
| `global.vault.authPath`    | Authentication path for Vault  | `supplychain` |
| `global.vault.secretEngine` | Vault secret engine name   | `secretsv2` |
| `global.vault.secretPrefix` | Vault secret prefix; must start with `data/`   | `data/supplychain` |

### Genesis image config parameters

| Name | Description | Default Value |
| - | - | - |
| `node.image` | The dscp-node or substrate image | `ghcr.io/inteli-poc/dscp-node` |
| `node.imageTag` | The dscp-node or substrate image tag | `v4.3.1`                |
| `node.pullPolicy` | dscp-node image pull | `IfNotPresent`           |
| `node.command` | The binary that will be executed to generate the genesis (this corresponds to the node.image) | `./dscp-node`   |
| `node.validator.count` | Specify the count of validator nodes | `4` |
| `node.member.count` | Specify the count of member nodes | `1` |
| `node.members.balance` | Pre-allocate some balance for the nodes | `1152921504606846976` |

## License

This chart is licensed under the Apache v2.0 license.

Copyright &copy; 2023 Accenture
