apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: "{{ component_name }}"
  annotations:
    fluxcd.io/automated: "false"
  namespace: "{{ component_ns }}"
spec:
  releaseName: "{{ component_name }}"
  interval: 1m
  chart:
    spec:
      interval: 1m
      chart: "{{ charts_dir }}/indy-node"
      sourceRef:
        kind: GitRepository
        name: flux-{{ network.env.type }}
        namespace: flux-{{ network.env.type }}
  values:
    global:
      serviceAccountName: vault-auth
      cluster:
        provider: "{{ cloud_provider }}"
        cloudNativeServices: false
      proxy:
        provider: ambassador
    
    storage:
      keys: "512Mi"
      data: "4Gi"
    
    image:
      indyNode:
        repository: ghcr.io/hyperledger/bevel-indy-node
        tag: 1.12.6
    
    settings:
      serviceType: ClusterIP
      node:
        publicIp: {{ node_public_ip }}
        port: {{ node_port }}
        externalPort: {{ node_external_port }}
      client:
        publicIp: {{ client_public_ip }}
        port: {{ client_port }}
        externalPort: {{ client_external_port }}
