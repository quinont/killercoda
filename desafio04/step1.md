
# Nuestras apps estan mezcladas :( 

Hola!!... hicimos un cambio en nuestras 2 apps (app1 y app2, si somos personas creativas), y ahora tenemos el problema de que las dos responden bien o hay veces que responde la otra app. No entendemos que pasa y ahora estamos asustados!.

Estos son las dos apps que tenemos:

- app1: `curl host01:30000/mypath`{{exec}}

- app2: `curl host01:31000/mypath`{{exec}}

tenes que probar varias veces cada servicio y vas a poder ver que unas veces te responde la app1 y otras la app2 no importa a que puerto vayas...

Por favor, ayudanos con esto que estamos ante un super problema en produccion y no sabemos cuanta plata vamos a perder :'(


En caso de que lo quieras ver en tu navegador:
- [app1]({{TRAFFIC_HOST1_30000/mypath}})
- [app2]({{TRAFFIC_HOST1_31000/mypath}})

