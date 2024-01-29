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
    chart: {{ charts_dir }}/quorum-ibft-crypto-gen
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
        authPath: {{ network.env.type }}{{ org_name }}
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
<<<<<<< HEAD
    labels:
=======
    vault:
      address: {{ vault.url }}
      role: vault-role
      authpath: {{ network.env.type }}{{ org_name }}
      serviceaccountname: vault-auth
      certsecretprefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org.name | lower }}
      retries: 30
      type: {{ vault.type | default("hashicorp") }}
    sleepTime: 10
>>>>>>> df76a9993380c4d21a2a51473064d1b81edb80ec
