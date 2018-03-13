package practica7JAVA;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EmpresaAutobuses {

    final static int KMGRANADACORDOBA = 156;
    final static int KMCORDOBAJAEN = 100;
    final static int KMGRANADAJAEN = 143;

    public static void main(String[] args) throws IOException {
        char eleccionUsuario;
        String nombreEstacion;
        String nombreCiudad;
        String ciudadOrigen;
        String ciudadDestino;
        String nombreConductor;
        int autobusSeleccionado;

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Vector conductores donde se guardaran 6 conductores
        Conductor []conductores = new Conductor[6];
        conductores[0] = new Conductor("453221F", "Maria", " Pintado", "CORDOBA");
        conductores[1] = new Conductor("74322343D", "Roberto", "Feijo","GRANADA");
        conductores[2] = new Conductor("12943294W", "Amparo","Reales","JAEN");
        conductores[3] = new Conductor("33425432S", "Jorge","Astur","CORDOBA");
        conductores[4] = new Conductor("77432734J", "Getulio","García","GRANADA");
        conductores[5] = new Conductor("19803434m", "Esperanza","López","JAEN");

        EstacionAutobuses []estacionAutobuses = new EstacionAutobuses[3];
        estacionAutobuses[0] = new EstacionAutobuses("CORDOBA", 4);
        estacionAutobuses[1] = new EstacionAutobuses("GRANADA", 5);
        estacionAutobuses[2] = new EstacionAutobuses("JAEN", 2);

        estacionAutobuses[0].introduceBusEnAndenVacio(new Autobus("1416FJW", "CORDOBA"));
        estacionAutobuses[0].introduceBusEnAndenVacio(new Autobus("9874AES", "CORDOBA"));
        estacionAutobuses[1].introduceBusEnAndenVacio(new Autobus("4522TJF", "GRANADA"));
        estacionAutobuses[1].introduceBusEnAndenVacio(new Autobus("3554DYH", "GRANADA"));
        estacionAutobuses[2].introduceBusEnAndenVacio(new Autobus("9657BBX", "JAEN"));
        estacionAutobuses[2].introduceBusEnAndenVacio(new Autobus("1243RSA", "JAEN"));

        //MOSTRAMOS MENU Y LEEMOS LA OPCION DEL USUARIO
        do {
            do {
                mostrarMenuPrincipal();
                eleccionUsuario = Character.toLowerCase(bufferedReader.readLine().charAt(0));

                if (eleccionUsuario < 'a' || eleccionUsuario > 'e')
                    System.out.println("\nOPCION INVALIDA\n");
            } while (eleccionUsuario < 'a' || eleccionUsuario > 'e');

            switch (eleccionUsuario)
            {
                // A - MOSTRAR AUTOBUSES DE UNA ESTACIÓN
                case 'a' :
                    System.out.println("Introduce el nombre de la estacion que quiere ver: ");
                    nombreEstacion = bufferedReader.readLine();
                    mostrarAutobusesEstacion(estacionAutobuses, nombreEstacion);
                    break;

                // B - MOSTRAR CONDUCTORES.
                case 'b' :
                    System.out.println("Introduce el nombre de la ciudad que quiere ver: ");
                    nombreCiudad = bufferedReader.readLine();
                    mostrarConductoresCiudad(conductores, nombreCiudad);
                    break;

                // C - GESTIONAR VIAJE.
                case 'c' :

                    System.out.println("Introduce el nombre de la ciudad de origen: ");
                    ciudadOrigen = bufferedReader.readLine().toUpperCase();

                    System.out.println("Introduce el nombre de la ciudad de destino: ");
                    ciudadDestino = bufferedReader.readLine().toUpperCase();

                    System.out.println();


                    mostrarConductoresCiudad(conductores,ciudadOrigen);
                    System.out.print("Introduce el nombre del conductor: ");
                    nombreConductor = bufferedReader.readLine();

                    mostrarAutobusesEstacion(estacionAutobuses, ciudadOrigen);
                    int estacionOrigen = buscarEstacion(estacionAutobuses, ciudadOrigen);

                    autobusSeleccionado = estacionAutobuses[estacionOrigen].devuelvePosicionAutobusLibre();

                    int estacionDestino = buscarEstacion(estacionAutobuses, ciudadDestino);

                    if (ciudadOrigen.equals("CORDOBA") && ciudadDestino.equals("JAEN"))
                    {
                        if (estacionAutobuses[estacionDestino].hayAndenVacio()
                                && estacionAutobuses[estacionDestino].getAutobus(autobusSeleccionado).asignarConductor(conductores[buscarConductor(conductores, nombreConductor)], KMCORDOBAJAEN))
                        {
                            estacionAutobuses[estacionOrigen].sacarAutobusDelAnden(autobusSeleccionado);

                            estacionAutobuses[estacionOrigen].getAutobus(autobusSeleccionado).hacerViaje(KMCORDOBAJAEN, ciudadDestino);

                            estacionAutobuses[estacionDestino].introduceBusEnAndenVacio(estacionAutobuses[estacionOrigen].getAutobus(autobusSeleccionado));

                            System.out.println("Fin del viaje");

                        }
                    }
                    break;

                // D - REINICIAR KILÓMETROS A LOS CONDUCTORES
                case 'd' : reiniciarKilometrosTodosConductores(conductores); break;

                // E - SALIR
                case 'e' : break;
            }
        } while ( eleccionUsuario != 'e');
    }

    private static void mostrarMenuPrincipal()
    {
        System.out.println("a. MOSTRAR AUTOBUSES DE UNA ESTACIÓN");
        System.out.println("b. MOSTRAR CONDUCTORES.");
        System.out.println("c. GESTIONAR VIAJE.");
        System.out.println("d. REINICIAR KILÓMETROS A LOS CONDUCTORES");
        System.out.println("e. SALIR");
    }

    private static int buscarEstacion(EstacionAutobuses []estacionAutobuses ,String nombreEstacion)
    {
        for (int i = 0; i < estacionAutobuses.length; i++)
            if (estacionAutobuses[i].getNombreCiudad().equals(nombreEstacion))
                return i;

        return -1;
    }

    private static void mostrarAutobusesEstacion(EstacionAutobuses []estacionAutobuses, String nombreEstacion)
    {
        int posicionEstacion;
        for (int i = 0; i < estacionAutobuses.length; i++) {
            posicionEstacion = buscarEstacion(estacionAutobuses, nombreEstacion);
            estacionAutobuses[posicionEstacion].mostrarAutobuses();
        }
    }

    private static int buscarConductor(Conductor []conductores, String nombreCiudad)
    {
        for (int i = 0; i < conductores.length; i++)
            if (conductores[i].getCiudadAlojamiento().equals(nombreCiudad))
                return i;

        return -1;
    }

    private static void mostrarConductoresCiudad(Conductor []conductores, String nombreCiudad)
    {
        int posicionConductor;
        for (int i = 0; i < conductores.length; i++) {
            posicionConductor = buscarConductor(conductores, nombreCiudad);
            System.out.println(conductores[posicionConductor].devolverDatosConductor());
        }
    }

    private static void reiniciarKilometrosTodosConductores(Conductor []conductores)
    {
        for (Conductor conductor: conductores)
            conductor.reiniciaKmMes();
    }

    //private void
}


/*

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