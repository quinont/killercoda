
### Modificando Pods

#### Primero

Podemos revisar cual es la configuracion actual, para esto ejecutamos:

Ejecutar: `kubectl get pod nginx-yaml -o yaml`{{exec}}

(puede ser que este archivo parezca chino basico, pero a la larga se va a entener mejor)

#### Segundo

Ahora podriamos cambiar el tipo de imagen de nginx a la version `1.23.0`. Para esto es necesario modificar el campo **image** dentro de `spec.containers`

El archivo deberia quedar algo asi:

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx-yaml
    creado-con: yaml
  name: nginx-yaml
spec:
  containers:
  - image: nginx:1.23.0
    name: nginx-yaml
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

Ahora aplicamos el cambio:

Ejecutar: `kubectl apply -f nginx.yaml `{{exec}}

Ahora vemos el pod que tenemos:

Ejecutar: `kubectl get pod`{{exec}}


#### Tercero

Si ahora volvemos a ejecutar el mismo comando que antes, notaremos que cambio la version de la imagen:

Ejecutar: `kubectl get pod nginx-yaml -o yaml`{{exec}}


