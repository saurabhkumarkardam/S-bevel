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
    chart: {{ charts_dir }}/quorum-tlscerts-gen
    sourceRef:
      kind: GitRepository
      name: flux-{{ network.env.type }}
      namespace: flux-{{ network.env.type }}
  values:
    nameOverride: {{ org.name }}
    global:
      vault:
        type: {{ vault.type | default("hashicorp") }}
        address: {{ vault.url }}
        role: vault-role
        authPath: {{ network.env.type }}{{ org_name }}
        serviceAccountName: vault-auth
        secretPrefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org.name | lower }}
    name: "{{ org.name }}"
    image:
      initContainerName: ghcr.io/hyperledger/bevel-alpine:latest
      certsContainerName: ghcr.io/hyperledger/bevel-build:jdk8-latest
      imagePullSecret: regcred
      pullPolicy: IfNotPresent
<<<<<<< HEAD
=======
    vault:
      address: {{ vault.url }}
      role: vault-role
      authpath: {{ network.env.type }}{{ org_name }}
      serviceaccountname: vault-auth
      certsecretprefix: {{ vault.secret_path | default('secretsv2') }}/data/{{ org.name | lower }}
      retries: 30
      type: {{ vault.type | default("hashicorp") }}
>>>>>>> df76a9993380c4d21a2a51473064d1b81edb80ec
    subjects:
      root_subject: "{{ network.config.subject }}"
      cert_subject: "{{ network.config.subject | regex_replace(',', '/') }}"
    opensslVars:
      domain_name: "{{ name }}.{{ external_url }}"
      domain_name_api: "{{ name }}api.{{ external_url }}"
      domain_name_web: "{{ name }}web.{{ external_url }}"
      domain_name_tessera: "{{ name }}-tessera.{{ component_ns }}"
      clientPort: {{ node.transaction_manager.clientport | default("8888") }}
    settings:
      removeGenesisOnDelete: true
    label:
