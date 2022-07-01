
### Creando pod a partir de un archivo yaml

#### Primero

En el ejemplo anterior creamos un pod con un solo comando, lo cual es perfecto cuando queremos hacer una prueba rapida de levantar un pod (o algun otro objeto) de kubernetes.

Pero ahora veremos otra forma que kubernetes nos permite trabajar con sus objetos los cuales son los archivos _yaml de manifiestos_.

Normalmente los archivos yaml de manifiestos tienen la siguiente estructura:

```yaml
apiVersion: 
kind: 
metadata:
...
spec:
...
```

Con la cli de Kubernetes podemos crear esta estructura, y eso lo hacemos de la siguiente manera:

Ejecutar: `kubectl run nginx-yaml --image=nginx --dry-run=client -o yaml > nginx.yaml`{{exec}}


Ejecutar: `cat nginx.yaml`{{exec}}


#### Segundo

Ahora vamos a agregar un label nuevo, el cual sera: `creado-con: yaml`

Editamos el archivo con algun editor (por ejemplo: vim), y agregamos esto dentro de metadata.labels:

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
  - image: nginx
    name: nginx-yaml
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

#### Tercero

Ahora vamos a crear el pod:

Ejecutar: `kubectl apply -f nginx.yaml`{{exec}}


#### Cuarto

Ver si se creo el pod.

Ejecutar: `kubectl get pod`{{exec}}
