############################################################# DEPLOY

kubectl apply -f examples/dscp-app/inteli-helm/cert-process/oem-web.yml
kubectl apply -f examples/dscp-app/inteli-helm/cert-process/oem-inteli-api.yml
kubectl apply -f examples/dscp-app/inteli-helm/cert-process/tierone-web.yml
kubectl apply -f examples/dscp-app/inteli-helm/cert-process/tierone-inteli-api.yml
kubectl apply -f examples/dscp-app/inteli-helm/cert-process/tiertwo-web.yml
kubectl apply -f examples/dscp-app/inteli-helm/cert-process/tiertwo-inteli-api.yml

############################################################# RESET

# kubectl delete secret oem-web-cert -n oem-subs
# kubectl delete secret oem-inteliapi-cert -n oem-subs
# kubectl delete secret tierone-web-cert -n oem-subs
# kubectl delete secret tierone-inteliapi-cert -n oem-subs
# kubectl delete secret tiertwo-web-cert -n oem-subs
# kubectl delete secret tiertwo-inteliapi-cert -n oem-subs

# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/oem-web.yml
# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/oem-inteli-api.yml
# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/tierone-web.yml
# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/tierone-inteli-api.yml
# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/tiertwo-web.yml
# kubectl delete -f examples/dscp-app/inteli-helm/cert-process/tiertwo-inteli-api.yml

############################################################# EXECUTE

# chmod +x build/cert-process/run.bash
# bash build/cert-process/run.bash
