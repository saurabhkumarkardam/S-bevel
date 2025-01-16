helm uninstall oem-dscp-api -n oem-subs
helm uninstall oem-postgresql -n oem-subs
helm uninstall oem-dscp-identity-service -n oem-subs
helm uninstall oem-inteli-api -n oem-subs
helm uninstall oem-dscp-frontend -n oem-subs
helm uninstall oem-chain-watcher -n oem-subs

helm install oem-dscp-api examples/dscp-app/charts/dscp-api -f examples/dscp-app/inteli-helm/oem-helm/dscp-api.yml -n oem-subs
helm install oem-postgresql examples/dscp-app/charts/postgresql -f examples/dscp-app/inteli-helm/oem-helm/postgresql.yml -n oem-subs
helm install oem-dscp-identity-service examples/dscp-app/charts/dscp-identity-service -f examples/dscp-app/inteli-helm/oem-helm/dscp-id-service.yml -n oem-subs
helm install oem-inteli-api examples/dscp-app/charts/inteli-api -f examples/dscp-app/inteli-helm/oem-helm/inteli-api.yml -n oem-subs

kubectl create secret docker-registry regcred -n oem-subs --docker-server=ghcr.io --docker-username=<docker-username> --docker-password=<github_token> --docker-email=<docker-email>
helm install oem-dscp-frontend examples/dscp-app/charts/dscp-frontend -f examples/dscp-app/inteli-helm/oem-helm/dscp-frontend.yml -n oem-subs

vault kv put secretsv2/oem/gcpkey gcpkey="$(cat {{ org.kinaxis.keyPath }})"
vault kv put secretsv2/oem/inteliAuth clientId="4QG5X9quHfzlqQq8n4E5v0MS6GCcMENP" clientSecret="V6RtbKCbw3SbmMyhIEa_i-ojWJGjM-bRiKnPS1ctKkGmWv05iaxB0avywPnuyX16"
kubectl apply -f examples/dscp-app/inteli-helm/utils/storageClass.yaml
helm install oem-chain-watcher examples/dscp-app/charts/dscp-chain-watcher -f examples/dscp-app/inteli-helm/oem-helm/chain-watcher.yml -n oem-subs

# chmod +x build/inteli-helm/oem-helm/run.sh
# bash build/inteli-helm/oem-helm/run.sh
