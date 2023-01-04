# Versionamiento
La nomenclatura de las versiones se realizará siguiendo el estándar de
versionamiento semántico, cuya descripción puede encontrarse en
[SemVer.org][1].

**Calendario de versiones**

  - No se utilizará un calendario de versiones.

  - Se generarán versiones *patch* para incidencias críticas detectadas
  en versiones publicadas de la librería.

  - Se generarán versiones *minor* o *major* según el estándar, para
  nuevas funcionalidades o mejoras que se consideren de interés
  inmediato. Se marcarán como *milestones* en el *roadmap* de
  desarrollo. Estas versiones incluirán la resolución de todas las
  incidencias no críticas resueltas hasta la fecha.

  - Transcurridas 2 semanas desde que se haya integrado una
  funcionalidad, mejora o incidencia sin ningún *milestone* “a la vista”
  (no está en desarrollo ninguna funcionalidad de interés inmediato),
  entonces se generará una versión *major*, *minor* o *patch* (según el
  estándar).

## Versionamiento semántico
> En el mundo de la gestión de software existe el temor de caer en algún
> momento en el llamado “infierno de las dependencias”. Mientras más
> grande crece tu sistema y mientras más paquetes integras en tu software,
> más probable es que te encuentres, un día, en este pozo de la
> desesperación.
>
> En sistemas con muchas dependencias, publicar nuevas versiones de un
> paquete puede transformarse rápidamente en una pesadilla. Si las
> especificaciones de dependencia son muy estrictas está el peligro del
> bloqueo de versiones (la imposibilidad de actualizar un paquete sin
> tener que actualizar todos los que dependen de este). Si las
> dependencias se especifican de manera muy amplia, inevitablemente caerás
> en promiscuidad de versiones (asumir más compatibilidad con versiones
> futuras de lo razonable). El infierno de las dependencias es donde te
> encuentras cuando el bloqueo de versiones o la promiscuidad de versiones
> te impiden avanzar en tu proyecto de manera fácil y segura.
>
> Como solución a este problema, propongo un set simple de reglas y
> requerimientos que dictan cómo asignar y cómo aumentar los números de
> versión. Para que este sistema funcione, tienes que declarar primero un
> API pública. Esto puede consistir en documentación o ser explicitado en
> el código mismo. De cualquier forma, es importante que esta API sea
> clara y precisa. Una vez que identificaste tu API pública, comunicas
> cambios a ella con aumentos específicos al número de versión. Considera
> un formato de versión del tipo X.Y.Z (Major.Minor.Patch) Los arreglos de
> bugs que no cambian el API incrementan el patch, los cambios y adiciones
> que no rompen la compatibilidad de las dependencias anteriores
> incrementan el minor, y los cambios que rompen la compatibilidad
> incrementan el major.
>
> Yo llamo a este sistema “Versionamiento Semántico”. Bajo este esquema,
> los números de versión y la forma en que cambian entregan significado
> del código que está detrás y lo que fue modificado de una versión a
> otra.
>
> ### Especificación
> En el documento original se usa el
> [RFC 2119](http://tools.ietf.org/html/rfc2119) para el uso de las
> palabras MUST, MUST NOT, SHOULD, SOULD NOT y MAY. Para que la traducción
> sea lo más fiel posible, he traducido siempre MUST por el verbo deber en
> presente (DEBE, DEBEN), SHOULD como el verbo deber en condicional
> (DEBERÍA, DEBERÍAN) y el verbo MAY como el verbo PODER.
>
>   1. El software que use Versionamiento Semántico DEBE declarar una API
>   pública. Esta API puede ser declarada en el código mismo o existir en
>   documentación estricta. De cualquier manera, debería ser precisa y
>   completa.
>
>   1. Un número normal de versión DEBE tomar la forma X.Y.Z donde X, Y, y
>   Z son enteros no negativos. X es la versión “major”, Y es la versión
>   “minor”, y Z es la versión “patch”. Cada elemento DEBE incrementarse
>   numéricamente en incrementos de 1. Por ejemplo: 1.9.0 -> 1.10.0 ->
>   1.11.0.
>
>   1. Una vez que un paquete versionado ha sido liberado (release), los
>   contenidos de esa versión NO DEBEN ser modificadas. Cualquier
>   modificación DEBE ser liberada como una nueva versión.
>
>   1. La versión major en cero (0.y.z) es para desarrollo inicial.
>   Cualquier cosa puede cambiar en cualquier momento. El API pública no
>   debiera ser considerada estable.
>
>   1. La versión 1.0.0 define el API pública. La forma en que el número
>   de versión es incrementado después de este release depende de esta API
>   pública y de cómo esta cambia.
>
>   1. La versión patch Z (x.y.Z | x > 0) DEBE incrementarse cuando se
>   introducen solo arreglos compatibles con la versión anterior. Un
>   arreglo de bug se define como un cambio interno que corrige un
>   comportamiento erróneo.
>
>   1. La versión minor Y (x.Y.z | x > 0) DEBE ser incrementada si se
>   introduce nueva funcionalidad compatible con la versión anterior. Se
>   DEBE incrementar si cualquier funcionalidad de la API es marcada como
>   deprecada. PUEDE ser incrementada si se agrega funcionalidad o
>   arreglos considerables al código privado. Puede incluir cambios de
>   nivel patch. La versión patch DEBE ser reseteada a 0 cuando la versión
>   minor es incrementada.
>
>   1. La versión major X (X.y.z | X > 0) DEBE ser incrementada si
>   cualquier cambio no compatible con la versión anterior es introducida
>   a la API pública. PUEDE incluir cambios de nivel minor y/o patch. Las
>   versiones patch y minor DEBEN ser reseteadas a 0 cuando se incrementa
>   la versión major.
>
>   1. Una versión pre-release PUEDE ser representada por adjuntar un
>   guión y una serie de identificadores separados por puntos
>   inmediatamente después de la versión patch. Los identificadores DEBEN
>   consistir solo de caracteres ASCII alfanuméricos y el guión
>   [0-9A-Za-z-]. Las versiones pre-release satisfacen pero tienen una
>   menor precedencia que la versión normal asociada. Ejemplos:
>   1.0.0-alpha, 1.0.0-alpha.1, 1.0.0-0.3.7, 1.0.0-x.7.z.92.
>
>   1. La metadata de build PUEDE ser representada adjuntando un signo más
>   y una serie de identificadores separados por puntos inmediatamente
>   después de la versión patch o la pre-release. Los identificadores
>   DEBEN consistir sólo de caracteres ASCII alfanuméricos y el guión
>   [0-9A-Za-z-]. Los meta-datos de build DEBIERAN ser ignorados cuando se
>   intenta determinar precedencia de versiones. Luego, dos paquetes con
>   la misma versión pero distinta metadata de build se consideran la
>   misma versión. Ejemplos: 1.0.0-alpha+001, 1.0.0+20130313144700,
>   1.0.0-beta+exp.sha.5114f85.
>
>   1. La precedencia DEBE ser calculada separando la versión en major,
>   minor, patch e identificadores pre-release en ese orden (La metadata
>   de build no figuran en la precedencia). Las versiones major, minor, y
>   patch son siempre comparadas numéricamente. La precedencia de
>   pre-release DEBE ser determinada comparando cada identificador
>   separado por puntos de la siguiente manera: los identificadores que
>   solo consisten de números son comparados numéricamente y los
>   identificadores con letras o guiones son comparados de acuerdo al
>   orden establecido por ASCII. Los identificadores numéricos siempre
>   tienen una precedencia menor que los no-numéricos. Ejemplo:
>   1.0.0-alpha < 1.0.0-alpha.1 < 1.0.0-beta.2 < 1.0.0-beta.11 <
>   1.0.0-rc.1 < 1.0.0.
>
>> Preston-Werner, Tom. Versionamiento semántico 2.0.0-rc2 (traducción
>> de Agustin Feuerhake) [[en línea][1]]. [Fecha de consulta: 20 de febrero
>> de 2018]

[1]:https://semver.org/lang/es/