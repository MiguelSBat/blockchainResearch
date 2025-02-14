Hacer uso de un Oráculo implica necesariamente que se minee el bloque, añadiendo tiempo de espera a la llamada de la API. Además si el callback está en el contrato (y no directamente en el usuario) tendrán que minarse 2 bloques para que la llamada se complete.

Oraclize tarda en la testnet 45 segundos en responder (3 bloques) y cobra un poco más de 0.004 eth para pagar la llamada al método__callback()

En la testnet se minea un bloque cada 15 segundos, esto implica que, tras la llamada a la API, el callback tarda entre 30 y 45 segundos.

Se ha testeado usando la API de YouTube, cuyo tiempo de respuesta no debería ser la razón por la que se llega a esa espera de al menos 30 segundos. Probablemente sea Oraclize quien añada ese tiempo extra.

Usando Oraclize (y tal y como está escrito ahora mismo el contrato) es muy poco viable usar el contrato de gateway. El hecho de que el timestamp sea puesto por el minero hace imposible (además de  susceptible a fraude) controlar el tiempo de respuesta real.

Si la red fuera privada y no una pública podría minarse un bloque cada menos tiempo, pudiendo controlar así el tiempo de respuesta real de la API. Sin embargo esto hace que sea más sencillo para un minero fraudulento controlar el timestamp del bloque.

Sería posible hacer un contrato encargado de comprobar la disponibilidad de una API pues no es dependiente del tiempo de minado del bloque. Aun así, para que fuera viable debería ser una llamada paralela a la llamada a la API original, a no ser que el tiempo de respuesta no sea importante para el usuario.
