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

### Genesis image config parameters

| Name | Description | Default Value |
| - | - | - |
| `node.image` | The dscp-node or substrate image | `ghcr.io/inteli-poc/dscp-node` |
| `node.imageTag` | The dscp-node or substrate image tag | `v4.3.1`                |
| `node.pullPolicy` | dscp-node image pull | `IfNotPresent`           |
| `node.command` | The binary that will be executed to generate the genesis (this corresponds to the node.image) | `./dscp-node`   |
| `node.validatorCount` | Specify the count of validator nodes |  |
| `node.memberCount` | Specify the count of member nodes |  |
| `node.members.name` | Node that has account information |  |
| `node.members.balance` | Pre-allocate some balance for the nodes |  |
| `node.members.nodes` | list of nodes that needs to be authorized along with account's address |  |

### Vault Parameters

| Name | Description | Default Value  |
| - | - | - |
| `vault.address` | URL of the Vault server | `""` |
| `vault.role` | The Vault role which will access the | `vault-role` |
| `vault.authpath` | The Auth Path configured on Hashicorp | `""` |
| `vault.serviceAccountName` | The service account that has been authenticated with Hashicorp Vault | `vault-auth` |
| `vault.certSecretPrefix` | The path where certificates are stored | `""` |

### DSCP-Node/Substrate Account Parameters

| Name                        | Description                                                                               | Default Value  |
| --------------------------- | ----------------------------------------------------------------------------------------- | ------ |
| `chain`          | The name of the chain which is embedded in the genesis               | `inteli` |
| `aura_keys`          | List of aura keys that will be added to the genesis               | `[]` |
| `grandpa_keys`          | List of grandpa keys that will be added to the genesis               | `[]` |
| `members`          | List of members with these attributes: `account_id`, `balance` and `nodes` list.               | `[]` |



## License

This chart is licensed under the Apache v2.0 license.

Copyright &copy; 2023 Accenture
