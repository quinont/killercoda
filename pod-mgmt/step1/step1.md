
### Creando Pods con kubectl

#### Primero

veremos cuantos pod hay en el namespace `default`.

Ejecutar: `kubectl get pod`{{exec}}


#### Segundo

crearemos un pod con nginx:

ejecutar: `kubectl run nginx --image=nginx`{{exec}}

#### Tercero

Veremos si se creo o no el pod.

Ejecutar: `kubectl get pod`{{exec}}
