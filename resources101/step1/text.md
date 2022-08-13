
# CPU

Primero vamos a comenzar con el uso de CPU. Entonces, comencemos con el example01:

```plain
cd /root/resources/cpu/example01/
```{{exec}}

Aqui encontraremos el archivo de nuestro primer ejemplo, con un cat lo podremos imprimir por consola para verlo en mas detalle:
```plain
cat cpu_example01.yaml
```{{exec}}

En este caso vamos a ver que nuestro container cpu-demo-ctr tiene definido el siguiente recurso para cpu:
```yaml
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "0.5"
```

Entonces para este container estamos definiendo un limite de 1 core, y 0.5 (o 500m) de cpu como request.

Por lo tanto, el container va a tener como limite 1 core mientras que lo que estamos por reservar en kubernetes va a ser de 500m de cpu en el nodo donde va a estar este pod.



En la parte de args vemos la configuracion del container:
```yaml
    args:
    - -cpus
    - "1"
```
En otras palabras lo que estamos viendo aqui es que vamos a decirle al container que tome 1 CPU.



## Deployemos nuestro POD

Para deployar el pod debemos ejecutar lo siguiente:
```plain
kubectl apply -f cpu_example01.yaml
```{{exec}}

Es necesario esperar unos 20 o 30 segundo para que nos aparezcan las metricas, asi que despues de unos segundo podemos ejecutar el siguiente comando para saber cuanto recursos esta consumiento el pod:
```plain
kubectl top pod
```{{exec}}

Nota: los nodos donde corre este ejemplo solo tienen 1 core, por lo tanto el pod puede que no llegue a 1000m sino que quede al rededor de 850m aproximadamente.


## Conclusion

Excelente!!, ya tenemos un pod consumiendo el limite de recursos que pusimos, en el proximo paso veremos que pasa si bajamos el limite y seguimos consumiendo 1 cpu.

> Algo importante antes de pasar al proximo ejemplo, por favor note que cuando vemos el consumo del pod con `kubectl top pod`, pero los limits/requests estan a nivel de container. 
> Tengamos en cuenta que un pod es un conjunto de containers, entonces los recursos se establecen por container, pero la metrica, en este caso, esta a nivel de pod.
