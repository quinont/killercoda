
# RAM superando el limite

Ahora vamos superar el limite, para esto vamos a ir a la carpeta donde esta el ejemplo:

```plain
cd /root/resources/ram/example02/
```{{exec}}

Mostramos el manifests para ver que es lo que estamos por hacer:
```plain
cat ram_example02.yaml
```{{exec}}

Los resources del container estan definidos igual que en el ejemplo anterior:
```yaml
    resources:
      requests:
        memory: "100Mi"
      limits:
        memory: "200Mi"
```

En la parte de los args vemos algo distinto:
```yaml
    args: ["--vm", "1", "--vm-bytes", "250M", "--vm-hang", "1"]
```
En otras palabras lo que tenemos aqui es que este container va a ocupar 250Mi de ram, superando al limite.

## Antes de deployar el pod

Como siempre, podemos ver como cambian los recursos disponibles de los nodos antes y despues de cambiar los limites:
```plain
resourceslist
```{{exec}}


## Deployemos nuestro pod

Para deployar el pod debemos ejecutar lo siguiente:
```plain
kubectl apply -f ram_example02.yaml
```{{exec}}

Es necesario esperar unos 20 o 30 segundo para que nos aparezcan las metricas, asi que despues de unos segundo podemos ejecutar el siguiente comando para saber cuanto recursos esta consumiento el pod:
```plain
kubectl top pod
```{{exec}}

Bueno.... en verdad no continues esperando para tener las metricas, las mismas nunca van a aparecer. Lo mejor seria que veas el estado de los restart del pod subieron mucho:
```plain
kubectl get pod
```{{exec}}

Vayamos a la conclusion....

## Conclusion

¿Que paso?? ¿¿por que mi pod se reinicia todo el tiempo?? ¿¿ que hice para merecer esto??

Bueno, lo explicaremos de forma facil, cuando el container supera la RAM limite, kubernetes reinicia el container. Por lo tanto, en este caso particular el limite de RAM es 200Mi, pero el container esta solicitando 250Mi, asi que siempre que supera los 200Mi, kubernetes lo termina reiniciando.


