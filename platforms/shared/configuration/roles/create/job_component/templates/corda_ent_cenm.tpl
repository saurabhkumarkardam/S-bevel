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
  cenm:
    sharedCreds:
      truststore: password
      keystore: password
    identityManager:
      port: 10000
      revocation:
        port: 5053
      internal:
        port: 5052
    auth:
      port: 8081
    gateway:
      port: 8080
    zone:
      enmPort: 25000
      adminPort: 12345
    networkmap:
      internal:
        port: 5050
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
subjects:
  # services.auth.subject
  auth: "CN=Test TLS Auth Service Certificate, OU=HQ, O=HoldCo LLC, L=New York, C=US"
  # services.signer.subject
  tlscrlsigner: "CN=Test TLS Signer Certificate, OU=HQ, O=HoldCo LLC, L=New York, C=US"
  # services.idman.crlissuer_subject
  tlscrlissuer: "CN=Corda TLS CRL Authority,OU=Corda UAT,O=R3 HoldCo LLC,L=New York,C=US"
  # org.subject
  rootca: "CN=DLT Root CA,OU=DLT,O=DLT,L=London,C=GB"
  # org.subordinate_ca_subject
  subordinateca: "CN=Test Subordinate CA Certificate, OU=HQ, O=HoldCo LLC, L=New York, C=US"
  # services.idman.subject
  idmanca: "CN=Test Identity Manager Service Certificate, OU=HQ, O=HoldCo LLC, L=New York, C=US"
  # services.networkmap.subject
  networkmap: "CN=Test Network Map Service Certificate, O
