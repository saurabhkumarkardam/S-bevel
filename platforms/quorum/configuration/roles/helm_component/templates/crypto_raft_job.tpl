apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: {{ component_name }}
  namespace: {{ component_ns }}
  annotations:
    fluxcd.io/automated: "false"
spec:
  releaseName: {{ component_name }}
  interval: 1m
  chart:
   spec:
    chart: {{ charts_dir }}/quorum-raft-crypto-gen
    sourceRef:
      kind: GitRepository
      name: flux-{{ network.env.type }}
      namespace: flux-{{ network.env.type }}
  values:
    nameOverride: {{ component_name }}
    global:
      vault:
        type: {{ vault.type | default("hashicorp") }}
        address: {{ vault.url }}
        role: vault-role
        authPath: quorum{{ org_name }}
        serviceAccountName: vault-auth
        secretPrefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org.name | lower }}
        retries: 30
        sleepTime: 10
    peer:
      name: {{ peer.name }}
      gethPassphrase: {{ peer.geth_passphrase }}
    image:
      initContainerName: ghcr.io/hyperledger/bevel-alpine:latest
      node: quorumengineering/quorum:{{ network.version }}
      pullPolicy: IfNotPresent
