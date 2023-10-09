
# Argo Rollout

Argo rollout es una herramineta que te ayuda a gestionar y controlar como se despliegan las nuevas versiones de tus aplicaciones.

Rollout en comparacion con el Deployment nativo de kubernetes, agrega 2 formas mas de despliegues para poder realizar las actualizaciones de formas mas controladas.

Las formas de despliegue con Argo rollout son:
- Blue-green
- Canary

Una de las principales caracteristicas que contiene Argo rollout son los "Analysis", estos procesos se ejecutan en los momentos de despliegue en donde podemos revisar si la nueva version funciona bien o tiene algun problema.

En este caso particular vamos a estar trabajando con Canary y analysis de demoras de respuestas y disponibilidad de las apps.

# Istio

Se va a ocupar istio como services mesh. Los services mesh proveen 3 principales cualidades:

- Monitoreo.
- Manejo de solicitudes.
- Seguridad.

Para este ejemplo, istio nos va a ayudar en los 2 primeros.

- Dando monitoreo para poder ejecutar los analysis con las metricas de cantidad de solicitudes y tiempos de demoras de las ejecuciones. Y lo mejor de todo, sin necesidad de modificar el codigo de la app.
- Dando el manejo de solicitudes a la version de canary.

# Otras tools instaladas

Aparte de istio y Argo rollout, se instalaron otras herramientas:

- Promethues: para guardar las metricas que se obtienen desde istio.
- Grafana: Para visualizar las metricas.
- Kiali: Para visualizar el mesh de istio.
- Jaeger: Monitoreo de las trazas, vamos a revisar esto en el ejemplo de kiali.


# La aplicacion

En este caso la aplicacion esta formada por 2 partes:
- Messenger: Una app que devuelve un mensaje. Tiene 2 variables de entorno que sirven para modificar la demora en las respuesta y otra para modificar la probabilidad de errores 500.
- Frontend: Una app que se conecta con messenger y devuelve su mensaje.


A continuacion comenzaremos con el deploy de las apps...
