global:
  serviceAccountName: vault-auth
  cluster:
    provider: "{{ cloud_provider }}"
    cloudNativeServices: false
    kubernetesUrl: "{{ kubernetes_server }}"
  vault:
    type: hashicorp
    role: vault-role
    network: corda-enterprise
    address: "{{ vault.url }}"
    authPath: "{{ org_name }}"
    secretEngine: secretsv2
    secretPrefix: "data/{{ org_name }}"
  proxy:
    provider: ambassador
    externalUrlSuffix: {{ external_url_suffix }}
settings:
  removeKeysOnDelete: true
tls:
  enabled: true
  settings:
    networkServices: true
storage:
  size: 1Gi
  dbSize: 5Gi
  allowedTopologies:
    enabled: false
