# Base McViper3
**SDK de la arquitectura de _Viper+ NTTData_.**

Este SDK recoge un conjunto de librerías para dar soporte a los distintos dominios definidos en la
arquitectura _Viper+ NTTData_.

## Repositorios
  - MacViper3
    + https://steps.everis.com/git/MOVILIDAD/baseviper

## Base McViper3
**SDK del Dominio de Operativas para _Viper+ NTTData__.**

Este SDK ofrece un conjunto de interfaces e implementaciones para cargar y presentar operativas así­ como para hacer uso de los servicios que estas ofrecen.

## Política de contribuciones
Antes de contribuir a este proyecto, por favor, revisa cuidadosamente
la [política de contribuciones][2]

[1]:Versioning.md
[2]:Contributing.md
[3]:Releases.md

## Compilación target FrameworkUniversal
Para compilar la librería debemos ejecutar la acción de tipo build sobre el target FrameworkUniversal, de este modo garantizamos obtener un framework con todas las arquitecturas disponibles.
Encontraremos el resultado de la compilación bajo la ruta *BaseVIPER -> (hay que comprobar el output*)

## Compilación target XCFramework
Para compilar la librería debemos ejecutar la acción *Cmnd + B* sobre el Target XCFramework, dicho Target implementa un Script en los *Build Phases*, que construye el XCFramework, para todas las arquitecturas disponibles, tanto de Simuladores como de Dispositivos Fisicos.

Encontrareis el resultado de la compilación bajo la ruta *BaseVIPER/Output/BaseVIPER.xcframework*

## Uso
### Requisitos
* iOS 11.0 o superior

### Instalación manual
Para utilizar la librería en un proyecto se incluirá en dicho proyecto como una dependencia:

1. Añadir el fichero de tipo framework a nuestro proyecto preferiblemente en una ruta de libreria de Terceros (*MyProject/MyFrameworks*).

2. En el apartado *General* del target, añadiremos el framework bajo *Embedded Binaries*, haciendo referencia al fichero compilado anteriormente, y tener en cuenta el modo *Embed Without Sign*

Esto debería añadir también una referencia al framework en *Linked Frameworks and Binaries*.

En caso de no hacer uso de un gestor de paquetes, el framework debe formar parte del proyecto, y cuando aplique, también de su repositorio.

### Carthage
En caso de utilizar Carthage para gestionar la dependencia de esta librería, deberemos añadir los siguientes datos al fichero Cartfile:
```
git "ssh://git@git-ssh.everis.com:766/MOVILIDAD/baseviper.git" "master"
```
Si fuese necesario utilizar una versión en concreto, o en su defecto una rama, modificaremos el segundo argumento("master"), por el valor requerido.

Para añadir el framework al proyecto se realizara del mismo modo en que se añaden el resto de dependencias gestionadas con Carthage.

### SPM (Swift Package Manager)

En caso de utilizar la arquitectura base como un package deberemos añadir el paquete mediante SPM con la última versión disponible.

A continuación añadimos el package con la siguiente url:

```
https://umane.everis.com/git/MOVILIDAD/baseviper
```
Con el gestor de package elegimos versión exacta y seleccionamos la última versión.

Por último, comprobamos si la dependencia está incluída en nuestro proyecto. Para ello seleccionamos el/los targets necesarios y comrpobamos que en la sección General dentro del apartado Frameworks, libraries and other dependencies, se encuentran nuestros package; De no ser así los incluímos manualmente.

### Consideraciones
La compilación de la líbreria contiene varias arquitecturas, algunas de ellas no pueden ser subidas a iTunes Connect, por ejemplo aquellas destinadas al simulador.
Por esto, si la líbreria tiene que ser distribuida a través de dicha plataforma junto con una aplicación, deberemos eliminar las arquitecturas no soportadas. Para ello podemos hacer uso de los conocidos como scripts de adelgazamiento. Este tipo de scripts, que habitualmente forman parte del proceso de compilación de la app, eliminan los *slices* de arquitecturas no requeridas.

## Versionamiento

La política de versionamiento puede consultarse en el fichero
[Versioning.md][1]

## Implementación de plantillas
Se ha creado una plantilla del proyecto base implementando el BaseVIPER
Dentro del paquete existe una carpeta llamada Templates que incluye el zip con todos los ficheros necesarios para autogenerar modulos VIPER.
Además se ha incluido un proyecto de ejemplo que implementa BaseVIPER, y el paquete de componentes que permite la abstracción de colecciones, tablas... además de compoenntes visuales.

```
https://umane.everis.com/git/MOVILIDAD/techradar-ios-uikit-components
```

## Implementación de AppDelegate
'''
    var window: UIWindow?
    var appInitializer: AppInitializerProtocol = AppInitializer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if window != nil {
            appInitializer.checkIfFirstOpen()
            self.appInitializer.installRootViewController()
        }
        return true
    }

'''
## Releases

[Releases.md][3]
