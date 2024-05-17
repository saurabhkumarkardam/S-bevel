apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: generate-keys
  annotations:
    fluxcd.io/automated: "false"
  namespace: {{ component_ns }}
spec:
  releaseName: generate-keys-first
  interval: 1m
  chart:
    spec:
      interval: 1m
      chart: {{ charts_dir }}/indy-key-mgmt
      sourceRef:
        kind: GitRepository
        name: flux-{{ network.env.type }}
        namespace: flux-{{ network.env.type }}
  values:
    global:
      serviceAccountName: vault-auth
      cluster:
        provider: {{ cloud_provider }}
        cloudNativeServices: false
        kubernetesUrl: {{ kubernetes_server }}
      vault:
        type: hashicorp
        role: vault-role
        network: indy
        address: {{ vault.url }}
        authPath: {{ org_name }}
        secretEngine: secretsv2
        secretPrefix: "data/{{ org_name }}"
    proxy:
      provider: ambassador
    settings:
      removeKeysOnDelete: true
      identities:
{% if trustee_name %}
        trustee: {{ trustee_name }}
{% endif %}
{% if endorser_name %}
        endorser: {{ endorser_name }}
{% endif %}
{% if steward_list %}
        stewards:
{% for steward in steward_list %}
          - {{ steward }}
{% endfor %}
{% endif %}
