FILE=/ks/wait-background.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}
export ISTIO_VERSION=1.19.1
curl -L https://istio.io/downloadIstio | TARGET_ARCH=x86_64 sh -
echo "export PATH=/root/istio-${ISTIO_VERSION}/bin:\$PATH" >> .bashrc
export PATH=/root/istio-${ISTIO_VERSION}/bin:$PATH
mv /tmp/demo.yaml /root/istio-${ISTIO_VERSION}/manifests/profiles/
istioctl install --set profile=demo -y --manifests=/root/istio-${ISTIO_VERSION}/manifests

# Installando argo rollout:
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/download/v1.6.0/install.yaml

curl -LO https://github.com/argoproj/argo-rollouts/releases/download/v1.6.0/kubectl-argo-rollouts-linux-amd64
chmod +x ./kubectl-argo-rollouts-linux-amd64
mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

# Instalando Prometheus, Kiali, jaeger y Grafana
kubectl apply -f /root/istio-${ISTIO_VERSION}/samples/addons/prometheus.yaml
kubectl apply -f /root/istio-${ISTIO_VERSION}/samples/addons/kiali.yaml
kubectl apply -f /root/istio-${ISTIO_VERSION}/samples/addons/jaeger.yaml
kubectl apply -f /root/istio-${ISTIO_VERSION}/samples/addons/grafana.yaml

echo "Termino la instalacion, a comenzar con la practica...."
