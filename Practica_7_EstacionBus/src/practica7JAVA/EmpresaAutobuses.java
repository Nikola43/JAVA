package practica7JAVA;

public class EmpresaAutobuses {

    final int KMGRANADACORDOBA = 156;
    final int KMCORDOBAJAEN = 100;
    final int KMGRANADAJAEN = 143;

    public static void main(String []args)
    {
        Conductor []conductores = new Conductor[6];

    }
}

/*
La clase MAIN será EmpresaAutobuses, y hará lo siguiente:
 Habrá 3 constantes llamadas KMGRANADACORDOBA con valor 156,
KMCORDOBAJAEN con valor 100 Y KMGRANADAJAEN con valor 143.

 Crear un vector conductores de tamaño 6 donde se guardarán estos conductores:
o Maria Pintado, con DNI 453221F y que estará alojada en la ciudad CORDOBA.
o Roberto Feijoo, con DNI 74322343D y que estará alojado en la ciudad GRANADA.
o Amparo Reales, con DNI 12943294W y que estará alojada en la ciudad JAEN.
o Jorge Astur, con DNI 33425432S y que estará alojado en la ciudad CORDOBA.
o Getulio García, con DNI 77432734J y que estará alojado en la ciudad GRANADA.
o Esperanza López, con DNI 19803434m y que estará alojado en la ciudad JAEN.
 Un vector de EstacionAutobuses que contendrá:
o Una estación en CORDOBA con 4 andenes.
o Una estación en GRANADA con 5 andenes.
o Una estación en JAEN con 2 andenes.
 En la estación de CORDOBA estarán inicialmente los autobuses con matrículas
“1416FJW” y “9874AES”.
 En la estación de GRANADA estarán inicialmente los autobuses con matrículas
“4522TJF” y “3554DYH”.
 En la estación de JAEN estarán inicialmente los autobuses con matrículas “9657BBX” y
“1243RSA”.
(hasta aquí: 0.5 puntos).
 Luego mostrará un menú para que el usuario elija la opción que quiera. Las opciones
son las siguientes:
o a. MOSTRAR AUTOBUSES DE UNA ESTACIÓN. Que pide al usuario el nombre de
la estación de la que quiere mostrar los autobuses y los muestra por pantalla.
(0.5 puntos)
o b. MOSTRAR CONDUCTORES. Que pide al usuario el nombre de la ciudad de
donde quiere mostrar los conductores que están allí alojados y los muestra por
pantalla.
(0.5 puntos)
o c. GESTIONAR VIAJE. Que pide al usuario la ciudad de origen del viaje y la
ciudad de destino del viaje (suponemos que es buena gente y meterá
correctamente los nombres de las ciudades, eso sí puede ponerlas en
minúsculas o mayúsculas).
Luego mostrará los conductores que hay alojados en esa ciudad para
asignarles el viaje y pedirá al usuario que indique qué conductor va a realizar el
viaje (aquí el usuario también será buena gente).
Una vez hecho lo anterior, selecciona un autobús libre en la ciudad de origen.
Y por último, si hay un andén vacío en la estación de destino y se puede
asignar un conductor al autobús seleccionado, el programa sacará del andén
de la estación de origen el autobús, hará el viaje e introducirá el autobús en
un andén vacío en la estación de destino.
Al acabar, mostrará un mensaje de éxito. Si no se puedo realizar el viaje, no se
hará nada de lo anterior y mostrará un mensaje de que el viaje no pudo
realizarse.
(1.5 puntos)
o d. REINICIAR KILÓMETROS A LOS CONDUCTORES. Que pondrá a 0 todos los km
de todos los conductores de la compañía.
(0.25 puntos)
 */