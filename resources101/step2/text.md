
# CPU superando el limite

Perfecto ahora vamos a continuar con el segundo ejemplo, primero vayamos a la carpeta:

```plain
cd /root/resources/cpu/example02/
```{{exec}}

Ahora veremos que vamos a hacer, asi que hacemos un cat al manifests:
```plain
cat cpu_example02.yaml
```{{exec}}

En este caso vamos a ver que nuestro container cpu-demo-ctr tiene definido el siguiente recurso para cpu:
```yaml
    resources:
      limits:
        cpu: "0.5"
      requests:
        cpu: "0.5"
```

Entonces, el container tiene el mismo requests que limite, (o sea 0.5 o 500m de CPU).


De todas formas en los args vamos a mantener el parametro de cpus en 1:
```yaml
    args:
    - -cpus
    - "1"
```

En otras palabras, vamos a tener el mismo consumo de CPU, pero ahora el limite (y el requests) es de 500m veremos que pasa :O


## Revisar los recursos asignado por nodo

En caso de querer saber cuantos recursos estamos ocupando podriamos volver a ejecutar el siguiente comando antes y despues:
```plain
resourceslist
```{{exec}}



## Deployemos nuestro pod

Para deployar el pod debemos ejecutar lo siguiente:
```plain
kubectl apply -f cpu_example02.yaml
```{{exec}}

Es necesario esperar unos 20 o 30 segundo para que nos aparezcan las metricas, asi que despues de unos segundo podemos ejecutar el siguiente comando para saber cuanto recursos esta consumiento el pod:
```plain
kubectl top pod
```{{exec}}


## Conclusion

¿Que paso?? -> por mas que nuestro container este pidiendo 1 CPU, kubernetes (con el limite que establecimos nosotros) solo llega a los 500m.

Excelente!! ya vimos como se comporta el limite en CPU. Ahora queda ver como funciona con respecto a la RAM, Asi que vamos al siguiente step!.

