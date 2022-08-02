
# Primera prueba

Ahora vamos a generar un error en el componente backend1, el mismo va a realizar una conexion hacia la app2, pero a su vez va a devolver al bff un error 503.

El siguiente es el diagrama de lo que estamos por revisar:

![Scan results](../assets/istioretry-scenario1.png)

Primero vamos a modificar el backend1 para que de el error:

```plain
kubectl set env deployment/backend1 STATUS_CODE_APP=503
```{{exec}}

Ahora limpiemos un poco los logs de las apps y reiniciemos todos los pods de los deployments
```plain
kubectl rollout restart deployment app2
```{{exec}}

```plain
kubectl rollout restart deployment bff
```{{exec}}

Esperamos hasta que todos los pods esten en estado Running.
```plain
kubectl get pod
```{{exec}}

Entonces si ahora probamos una llamada a nuestro endpoint tendremos:
```plain
curl http://localhost:30000/toapp; echo;
```{{exec}}

## Que paso???

Veamos los logs de las apps...
Para el bff:
```plain
kubectl logs -l app=bff
```{{exec}}

Para el backend1:
```plain
kubectl logs -l app=backend1
```{{exec}}

Para el app2:
```plain
kubectl logs -l app=app2
```{{exec}}

Lo que vamos a ver es lo siguiente:
- log de bff: solo una llamada, y este devuelve un 200.
- log de backend1: vamos a ver 3 llamadas, una en cada pod.
- log del app2: vamos a ver 3 llamadas tambien, pero no necesariamente va a ser una para cada pod.

## Explicacion

Entonces que paso?, lo que paso fue basicamente lo siguiente:
- desde el curl llamamos al bff.
- El bff llama a backend1.
- el backend1 llama a la app2.
- La app2 devuelve un 200 con el mensaje correspondiente.
- El backend1 devuelve un error 503 al bff. 
- En este momento comienza el sistema de retries de istio. Entonces el envoy proxy, marca al pod (del backend1) que devolvio el 503 como un pod conflictivo para no enviar mas solicitudes, y toma otro pod mas como destino (del backend1), para hacer su prueba. Asi que reintenta la solicitud una vez mas.
- La solicitud va al backend1.
- El backend1 envia la solicitud al app2.
- El app2 responde al backend1. 
- El backend1 responde un 503 al bff.
- En este momento el envoy vuelve a detectar otro error, y como el sistema por defecto de retries dice que son 2 veces, vuelve a hacer una prueba mas al backend1, esta vez la solicitud va al ultimo pod (si tuvieramos mas pod, el algoritmo tomaria un nuevo pod de la lista de los disponibles, pero si solo tendriamos dos, volveria al primero).
- Esto se repite de la misma manera que lo anterior.

## Entonces?

En el log del backend1 vemos 3 solicitudes que estan en 3 pod distintos, dado a que las politicas del retries en Istio dice que no se envie la solicitud al pod con problema.
Pero si vemos el log de la app2, no siempre va a estar distribuida la carga, dado a que, a esta app le llegaron tambien 3 solicitudes (pero esta siempre devolvio 200).
De todas formas el bff solo recibio una unica solicitud.


El proximo escenario vamos a correr el bug pero a la app2. Veremos que es lo que pasa.
