# Política de contribuciones

Todas las contribuciones al proyecto DEBEN realizarse mediante el
desarrollo de comandas creadas y aprobadas en [JIRA][1].

Cada comanda DEBE ser desarrollada en una rama propia de la
funcionalidad y DEBE ser integrada al código en desarrollo mediante una
solicitud de extracción (PR o _pull request_) que DEBE ser debidamente
probada y revisada para su aprobación.

El código aportado:
  1. DEBE estar respaldado por un documento técnico en [Confluence][2].
  1. DEBE cumplir estrictamente las guías de estilo.
  1. DEBE incluir test unitarios garantizando una cobertura del 30%.
  1. DEBE ser compilable cuando se integre con el resto del código
  existente en la rama de desarrollo.
  1. DEBE preservar el comportamiento verificable del resto del código
  existente en la rama de desarrollo.
  1. PUEDE presentar **deuda técnica** debidamente identificada y dada
  de alta como comanda en JIRA.


## Guías de estilo de código
Se aplicarán las guías de estilo de código del basado en swift y sus versiones liberadas por Apple.

## Política de ramas
**develop:** Rama destinada al desarrollo y la rama de integración para
el trabajo de tipo `feature`.

**feature:** Ramas destinadas al trabajo de nuevas *features* o mejoras.
Estas se integraran contra `develop` haciendo uso de *pull requests*.

**master:** Rama destinada a la ultima versión. En esta se integraran
las ramas del tipo `release`. Se integra contra la rama de desarrollo.

**release:** Ramas utilizadas para desplegar o ejecutar un mantenimiento
continuo de una versión.

**bugfix:** Ramas utilizadas para arreglar incidencias detectadas en una
rama del tipo `release` o incidencias no críticas detectadas en una
versión publicada de la librería.

**hotfix:** Ramas utilizadas para arreglar incidencias críticas
detectadas en una versión publicada de la librería.


## Nomenclatura ramas

**feature**

Con origen en comandas de primer nivel, las ramas del tipo `feature`
deben tener el siguiente formato:
```
feature/<identificador_comanda_Jira>
```

  - `<identificador_comanda_Jira>` es el identificador de JIRA utilizado para
  la comanda de primer nivel que requiere el desarrollo. Por ejemplo:
  EV-01234.

  En caso de que surja la necesidad de tener varias
  comandas/historias relacionadas a una comanda de primer nivel, la rama
  principal debería ser algo distinta, con el objetivo de poder tener
  varias ramas con un mismo prefijo, quedando así:
```
feature/<identificador_comanda>/name_feature
feature/<identificador_comanda>/subcomanda_name_feature.
```

**release**

Las ramas de tipo `release` están asociadas a una versión, por esto
deben contener el numero de esta:
```
release/<numero_version>
```

  - `<numero_version>` es el numero de version de la que formaran parte.
  Por ejemplo: 1.2

**bugfix**

Las ramas de tipo `bugfix` siempre tienen como destino una rama de tipo
`release` y están vinculados a una comanda de primer nivel. Por esto,
deben contener la versión de la que formaran parte y el identificador
de la comanda:

```
bugfix/<numero_version>/<identificador_comanda_Jira>
```

  - `<numero_version>` es el numero de version de la que formaran parte.
  Por ejemplo: 1.2
  - `<identificador_comanda>` es el identificador de JIRA utilizado para
  la comanda de primer nivel que requiere el desarrollo. Por ejemplo:
  JV-51820.

**hotfix**

Las ramas de tipo `hotfix` siempre tienen como destino la rama `master`
y la rama `develop`. Solucionan incidencias detectadas en una versión
concreta y están vinculados a una comanda de primer nivel.
Por esto, deben contener la versión de la que formaran parte y el
identificador de la comanda:

```
hotfix/<numero_version>/<identificador_comanda_Jira>
```

  - `<numero_version>` es el numero de version de la que formaran parte.
  Por ejemplo: 1.2
  - `<identificador_comanda>` es el identificador de JIRA utilizado para
  la comanda de primer nivel que requiere el desarrollo. Por ejemplo:
  JV-51820.

## *Pull Requests*
Las ramas tipo `feature`, `bugfix` y `hotfix` se integrarán a `release`,
`develop` y/o `master` mediante solicitudes de extracción (*pull
requests*).

Se establecen dos formatos específicos para las solicitudes de
extracción; un formato para las de tipo funcionalidad/mejora (ramas tipo
`feature`) que debe incluir una descripción simple de la funcionalidad o
mejora desarrollada, y un formato especifico para las de tipo incidencia
(ramas tipo `bugfix` y `hotfix`) que debe incluir en la descripción el
síntoma detectado, la causa subyacente que provoca el síntoma y la
solución a la causa (si no fuese posible aplicar una solución
definitiva, se incluirá también el detalle del parche aplicado y la
explicación de por qué no ha podido aplicarse la solución definitiva).

**Funcionalidad/Mejora**
```
Título: <identificador_comanda_Jira>: <nombre_comanda>

Descripción:
<Resumen de los cambios más importantes realizados.>
```
Ejemplo:
```
Título: EV-01234: Construcción de Ejemplo de implementación del framework BaseVIPER

Descripción:
Se aplica el desarrollo necesario para poder crear un Ejemplo de implementación del framework BaseVIPER.
```
**Incidencia**
```
Título: <identificador_comanda_Jira>: <nombre_comanda>

Descripción:
    Bug:
    <Descripción del síntoma de la incidencia>

    Causa:
    <Causa técnica que provoca el síntoma percibido>

    Solución:
    <Descripción de la solución que resuelve la causa subyacente>

    Impedimentos a la solución:
    <Explicación de por qué no ha podido aplicarse la solución>

    Parche:
    <Descripción del parche aplicado>
```
Ejemplo:
```
Título: EV-01234: Si la app está en backgroud con la ventana de timeline, no se presenta al usuario notificación

Descripción:
    Bug:
    Al recibir una push con el timeline abierto y la app en background
    no se muestra el banner de notificación

    Causa:
    El SDKManager comprueba la propiedad isVisible de fragment que no
    tiene en cuenta el estado foreground/background de la app.

    Solución:
    Añadir al fragment de chat un booleano "paused" que se actualize en
    los métodos onPause y onResume; y utilizar este estado para decidir
    si mostrar o no el banner de notificación.
```

[1]:Jira de everis
[2]:Confluence de everis