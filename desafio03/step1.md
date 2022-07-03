
# Nuevo deploy da error 404

Hola!, estamos realizando unos deploy de ultima hora para nuestro super core system, y cuando terminamos el deploy comenzamos a ver 404!!! antes esto funcionaba, no sabemos que puede ser, pero un rollback costaria muchas horas de desarrollo, Por favor ayudanos!!.

Lamentablemente, para nuestro flamante Backend necesitamos agregar un sidecard que nos permita 2 cosas:
- Controlar el trafico que llega a nuestro artefacto.
- Enrutar correctamente las solitudes que llegan al artefacto.

Actualmente tenemos un nginx como sidecard que nos ayuda a exponer nuestro servicio en la "/" de esta forma no tenemos que modificar nuestras apps que se conectan al servicio y podemos ocupar cualquier path para nuestro artefacto.

Entonces, es necesario que revise la configuracion y por favor no elimines el nginx.

Al ejecutar `curl host01:30000`{{exec}} estamos teniendo un 404, y necesitamos tener un 200.

Este es el link para probar el artefacto desde tu navegador: [Acceso al servicio]({{TRAFFIC_HOST1_30000}})


