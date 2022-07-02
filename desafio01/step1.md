
# Que paso con mi servicio?

Luego de un muy importante paso a produccion a primera hora de hoy, nos dimos cuenta que no estamos teniendo acceso al servicio... :'(...

Al ejecutar `curl host01:30000`{{exec}} No tenemos acceso a nuestro servicio.

Por favor, revisa porque el sevicio no esta respondiendo lo que deberia. Nuestro sistema es muy sensible ante cambios asi que por favor no cambies el nombre del servicio, ni tampoco el NodePort (el cual es 30000)

El ultimo devops que trabajo en nuestro cluster de kubernetes nos dio este link para probar desde afuera si el servicio funciona o no... 

[Acceso al servicio]({{TRAFFIC_HOST1_30000}})


