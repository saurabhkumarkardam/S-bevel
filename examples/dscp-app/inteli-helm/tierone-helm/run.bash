helm uninstall tierone-dscp-api -n tierone-subs
helm uninstall tierone-postgresql -n tierone-subs
helm uninstall tierone-dscp-identity-service -n tierone-subs
helm uninstall tierone-inteli-api -n tierone-subs
helm uninstall tierone-dscp-frontend -n tierone-subs
helm uninstall tierone-chain-watcher -n tierone-subs

# Under Test Dir
helm install tierone-dscp-api examples/dscp-app/charts/dscp-api -f examples/dscp-app/inteli-helm/tierone-helm/dscp-api.yml -n tierone-subs
helm install tierone-postgresql examples/dscp-app/charts/postgresql -f examples/dscp-app/inteli-helm/tierone-helm/postgresql.yml -n tierone-subs
helm install tierone-dscp-identity-service examples/dscp-app/charts/dscp-identity-service -f examples/dscp-app/inteli-helm/tierone-helm/dscp-id-service.yml -n tierone-subs
helm install tierone-inteli-api examples/dscp-app/charts/inteli-api -f examples/dscp-app/inteli-helm/tierone-helm/inteli-api.yml -n tierone-subs

kubectl create secret docker-registry regcred -n tierone-subs  --docker-server=ghcr.io --docker-username=<docker-username> --docker-password=<github_token> --docker-email=<docker-email>

helm install tierone-dscp-frontend examples/dscp-app/charts/dscp-frontend -f examples/dscp-app/inteli-helm/tierone-helm/dscp-frontend.yml -n tierone-subs

vault kv put secretsv2/tierone/inteliAuth clientId="4QG5X9quHfzlqQq8n4E5v0MS6GCcMENP" clientSecret="V6RtbKCbw3SbmMyhIEa_i-ojWJGjM-bRiKnPS1ctKkGmWv05iaxB0avywPnuyX16"
helm install tierone-chain-watcher examples/dscp-app/charts/dscp-chain-watcher -f examples/dscp-app/inteli-helm/tierone-helm/chain-watcher.yml -n tierone-subs


# chmod +x build/inteli-helm/tierone-helm/run.bash
# bash build/inteli-helm/tierone-helm/run.bash
