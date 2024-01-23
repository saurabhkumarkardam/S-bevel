apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: {{ component_name }}
  namespace: {{ component_ns }}
  annotations:
    flux.weave.works/automated: "false"
spec:
  releaseName: {{ component_name }}
  interval: 1m
  chart:
   spec:
    chart: {{ charts_dir }}/quorum-tessera-key-mgmt
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
        secretEngine: {{ vault.secret_path | default('secretsv2') }}
        authPath: {{ network.env.type }}{{ org_name }}
        role: vault-role
        serviceAccountName: vault-auth
        tmPrefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org_name }}/crypto
        keyPrefix: {{ org_name }}/crypto
    peer:
      name: {{ peer.name }}
    image:
      repository: quorumengineering/tessera:hashicorp-{{ network.config.tm_version }}
      pullSecret: regcred
<<<<<<< HEAD
=======
    vault:
      address: {{ vault.url }}
      secretengine: {{ vault.secret_path | default('secretsv2') }}
      authpath: {{ network.env.type }}{{ org_name }}
      keyprefix: {{ org_name }}/crypto
      role: vault-role
      serviceaccountname: vault-auth
      tmprefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org_name }}/crypto
      type: {{ vault.type | default("hashicorp") }}
>>>>>>> upstream/develop
