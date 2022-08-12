FILE=/ks/wait-background.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}

echo "esperando por el deploy del metric server..."
kubectl rollout status deploy/metrics-server -n kube-system

echo "Todo listo"
