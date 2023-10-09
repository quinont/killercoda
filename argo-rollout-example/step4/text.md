# Errores de disponibilidad en la version 3

Ahora veremos que pasa si nuestro artefacto no performa correctamente:

Para ello vamos a cambiar a la version 3, y aparte vamos a modificar la variable "ERROR_THRESHOLD" con 80 (esto hace que el 80 % de las solicitudes que llegan a la app retornen un 500).

```
kubectl patch rollout messenger -n messenger --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "quinont/messenger-backend:3"}, {"op":"replace", "path": "/spec/template/spec/containers/0/env/0/value", "value": "80"}]'
```{{exec}}

En este momoento podemos ir al tab 2 y ver que cada ciertas requests obtenemos un error por la terminal.

Para ver el estado del rollout volvemos a ejecutar el comando:
```plain
kubectl argo rollouts get rollout messenger -n messenger -w
```{{exec}}

Despues de unas iteraciones, vamos a ver que el analysis detecto mas de 4 errores y cancelo el proceso de despliegue.


# Grafana

Con grafana podemos revisar como se estan comportando nuestras metricas de "Disponibilidad" y "Tiempo de Respuesta" en nuestro artefacto Messenger. Tenemos que entender que lo mejor es crear un dashboard en grafana donde poder ver estas metricas como se modifican, pero por esta vez, podriamos ejecutar las querys de prometheus en el "explorer".

Antes que nada, vamos al tab 3, en caso de estar ejecutandose, paramos la ejecucion del tunnel para kiali y ejecutamos el siguiente comando:
```plain
kubectl port-forward -n istio-system svc/grafana --address 0.0.0.0 20001:3000
```{{exec}}

De alli nos vamos al explorer, y podemos ejecutar las querys:

Disponibilidad:
```
sum(irate(
  istio_requests_total{  
    reporter="source",
    destination_service=~"messenger-canary.messenger.svc.cluster.local",
    response_code=~"2.*"
  }[2m]
)) / sum(irate(
  istio_requests_total{
    reporter="source",
    destination_service=~"messenger-canary.messenger.svc.cluster.local"
  }[2m]
))
```{{copy}}

Tiempo de respuesta:
```
sum(irate(
  istio_request_duration_milliseconds_sum{
    reporter="source",
    destination_service=~"messenger-canary.messenger.svc.cluster.local"
  }[2m]
)) / sum(irate(
  istio_request_duration_milliseconds_count{
    reporter="source",
    destination_service=~"messenger-canary.messenger.svc.cluster.local"
  }[2m]
))
```{{copy}}




