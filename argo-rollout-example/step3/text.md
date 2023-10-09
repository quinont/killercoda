# Pasando a la nueva version

IMPORTANTE: es importante dejar corriendo el script que llama a la app mientras se ejecuta todos estos comandos en la primera terminal.
En caso contrario podemos llegar a tener un error como este:
```
RolloutAborted: Rollout aborted update to revision 2: Metric "success-rate" assessed Error due to consecutiveErrors (5) > consecutiveErrorLimit (4): "Error Message: reflect: slice index out of range"
```

Primero ejecutamos el siguiente comando:

```plain
kubectl argo rollouts set image messenger -n messenger messenger=quinont/messenger-backend:2
```{{exec}}

Esto permite pasar a la nueva version, la nueva version no tiene errores y por lo tanto los analysis van a terminar en OK.

Para poder revisar el estado del deploy podemos ejecutar el siguiente comando:

```plain
kubectl argo rollouts get rollout messenger -n messenger -w
```{{exec}}

NOTA: Para poder salir es necesario ejecutar contro+c

Si vamos a la tab 2, podremos ver que cada tanto aparecen mensajes que estamos en la version 2, estos mensajes se van a ver cada vez mas de seguidos dado a que aumenta la cantidad de mensajes a la nueva version.

## Pero... que esta pasando???

Lo que esta pasando en este momento es que se va a ir migrando el trafico desde la version nueva a la version vieja, esta configuracion se encuentra en el [archivo del rollout de messenger|https://github.com/quinont/argo-rollout-example/blob/main/manifests/messenger/01-rollout.yaml] en la siguiente parte:

```yaml
  strategy:
    canary:
      canaryService: messenger-canary
      stableService: messenger
      trafficRouting:
        istio:
          virtualService:
            name: messenger
            routes:
            - primary
      steps:
      - setWeight: 10
      - pause: {duration: 3m}
      - setWeight: 30
      - pause: {duration: 2m}
      - setWeight: 50
      - pause: {duration: 2m}
      - setWeight: 80
      - pause: {duration: 2m}
      analysis:
        templates:
        - templateName: avial-latency-metric
        startingStep: 2
        args:
        - name: service-name
          value: "messenger-canary.messenger.svc.cluster.local"
```

Eso significa que pondra un peso de 10 al virtualservice de istio, y va a esperar 3 minutos. Despues aumenta a 30 y espera 2 min, despues 50 y espera 2 min mas, y para terminar deja en el 80% del trafico y espera los ultimos 2 minutos.

A partir del paso 2, comienza a ejecutar el [analysis|https://github.com/quinont/argo-rollout-example/blob/main/manifests/messenger/03-analysistemplate.yaml] el cual es el siguiente:

```yaml
spec:
  args:
  - name: service-name
  metrics:
  - name: success-rate
    interval: 10s
    successCondition: result[0] >= 0.8
    failureCondition: result[0] < 0.8
    failureLimit: 3
    provider:
      prometheus:
        address: http://prometheus.istio-system:9090
        query: |
          sum(irate(
            istio_requests_total{  
              reporter="source",
              destination_service=~"{{args.service-name}}",
              response_code=~"2.*"
            }[2m]
          )) / sum(irate(
            istio_requests_total{
              reporter="source",
              destination_service=~"{{args.service-name}}"
            }[2m]
          ))
  - name: avg-req-duration
    interval: 10s
    successCondition: result[0] <= 500
    failureCondition: result[0] > 500
    failureLimit: 3
    provider:
      prometheus:
        address: http://prometheus.istio-system:9090
        query: |
          sum(irate(
            istio_request_duration_milliseconds_sum{
              reporter="source",
              destination_service=~"{{args.service-name}}"
            }[2m]
          )) / sum(irate(
            istio_request_duration_milliseconds_count{
              reporter="source",
              destination_service=~"{{args.service-name}}"
            }[2m]
          ))
```

Que hace el analysis??

En este caso ejecutamos 2 querys contra promethues cada 10 segundos y en caso de mas de 3 fallas (no es necesario que sean consecutivas) da un error en el deploy y realiza un rollback.

Las querys son:
- success-rate: Calcula la cantidad de 200 sobre el total de requests, en caso de que este numero sea mayor a 0.8 dice que esta ok la app.
- avg-req-duration: Calcula el tiempo de latencia promedio de las apps. Si la latency supera los 500ms entonces indica que hay un error.


# Kiali

Ahora que estamos en proceso de migracion a la nueva version, podemos ver como se comporta el mesh mediante kiali.

Para poder abrir kiali aconsejo crear un nuevo tab y ejecutar el siguiente comando:

```plain
kubectl port-forward -n istio-system svc/kiali --address 0.0.0.0 20001:20001
```{{exec}}


Esto expone el puerto de kiali a internet y podremos entrar desde el browser haciendo [hacer clic aca]({{TRAFFIC_HOST1_20001}})
