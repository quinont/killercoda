
# Retry en Istio

La arquitectura propuesta para revisar este ejemplo consta de 3 microservicios, los cuales son:
- bff:
- backend1:
- app2:

La conexion entre las mismas esta dentalla en la siguiente imagen:

![Scan results](../assets/istioretry-scenario.png)

Primero es necesario crear el ambiente, para hacerlo todo mas facil vamos a ocupar el namespace default:

```plain
kubectl label namespace default istio-injection=enabled --overwrite
```{{exec}}

Ahora es necesario deployar las aplicaciones:
```plain
kubectl apply -f scenario/
```{{exec}}


Para poder probar es necesario realizar un curl a localhost de la siguiente manera:

```plain
curl http://localhost:30000/toapp
```{{exec}}


Los manifests de la app se encuentran en la carpeta scenario.
