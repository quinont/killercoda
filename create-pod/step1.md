
### Que vamos a hacer?

#### Primero

veremos cuantos pod hay en el namespace `default`.

Ejecutar: `kubectl get pod`{{exec}}


#### Segundo
crearemos un pod con nginx:

ejecutar: `kubectl run nginx --image=nginx`{{exec}}

#### Ultimo 

Veremos si se creo o no el pod.

Ejecutar: `kubectl get pod`{{exec}}
