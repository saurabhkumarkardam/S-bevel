image:
  cli: ghcr.io/hyperledger/bevel-indy-ledger-txn:latest
  pullSecret:
network: bevel
admin: {{ trustee_name }}
newIdentity:
  name: {{ endorser_name }}
  role: ENDORSER
