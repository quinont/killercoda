# Deploy del artefacto

Como primer paso es necesario bajar el codigo de la app de https://github.com/quinont/argo-rollout-example

```plain
git clone https://github.com/quinont/argo-rollout-example.git
```{{exec}}

Creamos los namespaces y los configuramos para que los pods esten dentro del mesh:

```plain
kubectl create namespace messenger
kubectl create namespace frontend
kubectl label namespace messenger istio-injection=enabled
kubectl label namespace frontend istio-injection=enabled
```{{exec}}

Ahora vamos a deployar el backend messenger:

```plain
cd argo-rollout-example/manifests/messenger/
kubectl apply -f .
```{{exec}}

Ahora a deployar el frontend:

```plain
cd ../frontend/
kubectl apply -f .
```{{exec}}

Ahora revisamos como esta funcionando todo:
```plain
kubectl get pod -n messenger
```{{exec}}

```plain
kubectl get pod -n frontend
```{{exec}}

# Probando la aplicacion

Podemos porbar la app pegandole con un curl:
```plain
export ingress_port=$(kubectl get svc -n istio-system -ojsonpath='{.spec.ports[?(@.name=="http2")].nodePort}' istio-ingressgateway)
curl -s localhost:${ingress_port}/ 
```{{exec}}

O tambien podemos [hacer clic aca]({{TRAFFIC_HOST1_30000}})


# Inyectando trafico

Para poder hacer las pruebas vamos a generar trafico a nuestras apps.

**IMPORTANTE**: Es necesario crear un nuevo tab para poder realizar trafico sin necesidad de que tengamos la terminal bloqueda.

Para esto es neceario crear una nueva terminal y ejecutar lo siguiente:
```plain
export ingress_port=$(kubectl get svc -n istio-system -ojsonpath='{.spec.ports[?(@.name=="http2")].nodePort}' istio-ingressgateway)
while true; do echo -n $(date +"[%m-%d %H:%M:%S]"); curl -s localhost:${ingress_port}/ | grep "El mensaje es:" ; sleep 1; done
```{{exec}}


A partir de este punto ya estamos todo armado, ahora a comenzar a actualizar la app en el siguiente step...

