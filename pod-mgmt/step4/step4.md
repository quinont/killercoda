
### Eliminando los pods

#### Primero

Vamos a eliminar los pod que creamos. Primero vamos a eliminar el pod que se creo mediante el manifest.

Para esto vamos a ejecutar lo siguiente:

Ejecutar: `kubectl delete -f nginx.yaml`{{exec}}

Esperando unos segundos, podemos ver que ya no esta mas el pod `nginx-yaml`.

Ejecutar: `kubectl get pod`{{exec}}


#### Segundo

Ahora vamos a eliminar el pod que creamos con la cli. Para ello vamos a eliminar de la siguiente manera:

Ejecutar: `kubectl delete pod nginx`{{exec}}

Igual que antes, tenemos que esperar unos segundos y ahora podremos ver si el pod continua o no con vida (muajajaja):

Ejecutar: `kubectl get pod`{{exec}}
