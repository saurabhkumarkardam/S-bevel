helm uninstall tiertwo-dscp-api -n tiertwo-subs
helm uninstall tiertwo-postgresql -n tiertwo-subs
helm uninstall tiertwo-dscp-identity-service -n tiertwo-subs
helm uninstall tiertwo-inteli-api -n tiertwo-subs
helm uninstall tiertwo-dscp-frontend -n tiertwo-subs
helm uninstall tiertwo-chain-watcher -n tiertwo-subs

# Under Test Dir
helm install tiertwo-dscp-api examples/dscp-app/charts/dscp-api -f examples/dscp-app/inteli-helm/tiertwo-helm/dscp-api.yml -n tiertwo-subs
helm install tiertwo-postgresql examples/dscp-app/charts/postgresql -f examples/dscp-app/inteli-helm/tiertwo-helm/postgresql.yml -n tiertwo-subs
helm install tiertwo-dscp-identity-service examples/dscp-app/charts/dscp-identity-service -f examples/dscp-app/inteli-helm/tiertwo-helm/dscp-id-service.yml -n tiertwo-subs
helm install tiertwo-inteli-api examples/dscp-app/charts/inteli-api -f examples/dscp-app/inteli-helm/tiertwo-helm/inteli-api.yml -n tiertwo-subs

kubectl create secret docker-registry regcred -n tiertwo-subs  --docker-server=ghcr.io --docker-username=<docker-username> --docker-password=<github_token> --docker-email=<docker-email>

helm install tiertwo-dscp-frontend examples/dscp-app/charts/dscp-frontend -f examples/dscp-app/inteli-helm/tiertwo-helm/dscp-frontend.yml -n tiertwo-subs

vault kv put secretsv2/tiertwo/inteliAuth clientId="4QG5X9quHfzlqQq8n4E5v0MS6GCcMENP" clientSecret="V6RtbKCbw3SbmMyhIEa_i-ojWJGjM-bRiKnPS1ctKkGmWv05iaxB0avywPnuyX16"
helm install tiertwo-chain-watcher examples/dscp-app/charts/dscp-chain-watcher -f examples/dscp-app/inteli-helm/tiertwo-helm/chain-watcher.yml -n tiertwo-subs


# chmod +x build/inteli-helm/tiertwo-helm/run.sh
# bash build/inteli-helm/tiertwo-helm/run.sh
