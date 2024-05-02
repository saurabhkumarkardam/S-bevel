apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: {{ component_name | replace('_','-') }}
  namespace: {{ component_ns }}
  annotations:
    fluxcd.io/automated: "false"
spec:
  interval: 1m
  releaseName: {{ component_name | replace('_','-') }}
  chart:
    spec:
      interval: 1m
      sourceRef:
        kind: GitRepository
        name: flux-{{ network.env.type }}
        namespace: flux-{{ network.env.type }}
      chart: {{ charts_dir }}/substrate-genesis
  values:
    node:
      name: {{ component_name }}
      image: {{ network.docker.url }}/{{ network.config.node_image }}
      imageTag: {{ network.version }}
      pullPolicy: IfNotPresent
      command: {{ network.config.command }}
      validator:
        count: {{ validator_count }}
      member:
        count: {{ member_count }}
        balance: 1152921504606846976
    vault:
      address: {{ vault.url }}
      role: vault-role
      authpath: {{ network.env.type }}{{ name }}
      serviceaccountname: vault-auth
      certsecretprefix: {{ vault.secret_path | default('secretsv2') }}/{{ name }}
    chain: {{ network.config.chain }}

