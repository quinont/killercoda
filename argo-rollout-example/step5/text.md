# Aumentos de tiempo de respuesta

En este caso veremos otro de los problemas que podria traer una nueva version de nuestro artefacto, Aumento del tiempo de respuesta.

Para ello vamos a cambiar a la version 3, y aparte vamos a modificar la variable "MAX_DELAY_MS" con 2000 (Con esto vamos a hacer que las requests al nuevo servicio puedan demorar de 0 a 2000ms en ejecutarse).

Nota: como continuamos del ejemplo anterior, tambien es necesario poner en 0 la variable "ERROR_THRESHOLD" Para no tener errores en las requests.

```
kubectl patch rollout messenger -n messenger --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "quinont/messenger-backend:3"}, {"op":"replace", "path": "/spec/template/spec/containers/0/env/0/value", "value": "0"}, {"op":"replace", "path": "/spec/template/spec/containers/0/env/1/value", "value": "2000"}]'
```{{exec}}

En este momoento podemos ir al tab 2 y ver que cada ciertas requests el tiempo de respuesta sube mucho.

Para ver el estado del rollout volvemos a ejecutar el comando:
```plain
kubectl argo rollouts get rollout messenger -n messenger -w
```{{exec}}

Despues de unas iteraciones, vamos a ver que el analysis detecto mas de 4 errores (por aumento del tiempo de respuesta) y cancelo el proceso de despliegue.
