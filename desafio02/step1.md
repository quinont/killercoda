
# Nuevo deploy da error 502

Hace unos minutos pasamos a la nueva version de nuestro increible backend... De todas formas, todo dejo de funcionar... pero el servicio anda, debe ser otro el problema.

Al ejecutar `curl host01:30000`{{exec}} No tenemos acceso a nuestro servicio.

Por favor, arregla nuestro pequeño problema, nuestros backend anda perfecto asi que no lo toques, Por otro lado, nuestra app se debe exponer como nodeport con puerto 30000, dado a que otra app se conecta a esta.

El ultimo devops que trabajo en nuestro cluster de kubernetes nos dio este link para probar desde afuera si el servicio funciona o no... 

[Acceso al servicio]({{TRAFFIC_HOST1_30000}})


