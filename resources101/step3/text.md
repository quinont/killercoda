
# RAM

Terminando de ver la parte del uso de recursos para CPU, arrancamos con el uso de RAM. 

Antes que nada, vamos a la carpeta donde estan nuestros archivos:

```plain
cd /root/resources/ram/example01/
```{{exec}}

Aqui encontraremos el archivo del ejemplo, con un cat lo podremos imprimir por consola para verlo en mas detalle:
```plain
cat ram_example01.yaml
```{{exec}}

En este caso vamos a ver que nuestro container memory-demo-ctr tiene definido el siguiente recurso para ram:
```yaml
    resources:
      requests:
        memory: "100Mi"
      limits:
        memory: "200Mi"
```

Entonces para este container estamos definiendo un limite de 200Mi y un request de 100Mi.

> Importante: esto significa que vamos a estar reservando en el nodo 100Mi, y permitiremos al container que consuma hasta 200Mi.


En la parte de args vemos la configuracion del container:
```yaml
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]
```
De todos estos parametros el que mas nos importa es la parte de `--vm-bytes 150M`, en otras palabras, esto significa que nuestro container consumira 150M cuando se levante.

## Antes de deployar el pod

Como los casos anteriores, podemos revisar antes y despues cuandoto estamos consumiendo de recursos por nodo con el siguiente comando:
```plain
resourceslist
```{{exec}}

## Deployemos nuestro pod

Para deployar el pod debemos ejecutar lo siguiente:
```plain
kubectl apply -f ram_example01.yaml
```{{exec}}

Es necesario esperar unos 20 o 30 segundo para que nos aparezcan las metricas, asi que despues de unos segundo podemos ejecutar el siguiente comando para saber cuanto recursos esta consumiento el pod:
```plain
kubectl top pod
```{{exec}}


## Conclusion

Excelente!!, Tenemos un pod que posee un container y este container esta consumiendo 150Mi, eso quiere decir que el consumo esta en el medio del requests (100Mi) y el limite (200Mi). Veremos en el siguiente paso que pasa cuando superamos el limite... 

