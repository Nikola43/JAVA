package practica7JAVA;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EmpresaAutobuses {

    final static int KMGRANADACORDOBA = 156;
    final static int KMCORDOBAJAEN = 100;
    final static int KMGRANADAJAEN = 143;
    private static String matriculaBus;

    public static void main(String[] args) throws IOException {
        char eleccionUsuario;
        String nombreEstacion;
        String nombreCiudad;
        String ciudadOrigen;
        String ciudadDestino;
        String nombreConductor;
        int autobusSeleccionado;
        int estacionOrigen;
        int estacionDestino;

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
                    nombreEstacion = bufferedReader.readLine().toUpperCase();
                    mostrarAutobusesEstacion(estacionAutobuses, nombreEstacion);
                    break;

                // B - MOSTRAR CONDUCTORES.
                case 'b' :
                    System.out.println("Introduce el nombre de la ciudad que quiere ver: ");
                    nombreCiudad = bufferedReader.readLine().toUpperCase();
                    mostrarConductores(buscarConductoresCiudad(conductores, nombreCiudad));
                    break;

                // C - GESTIONAR VIAJE.
                case 'c' :

                    //Se pide al usuario la ciudad de origen del viaje y la
                    //ciudad de destino del viaje
                    System.out.println("Introduce el nombre de la ciudad de origen: ");
                    ciudadOrigen = bufferedReader.readLine().toUpperCase();

                    System.out.println("Introduce el nombre de la ciudad de destino: ");
                    ciudadDestino = bufferedReader.readLine().toUpperCase();
                    System.out.println();

                    //mostrará los conductores que hay alojados en esa ciudad para
                    //asignarles el viaje
                    mostrarConductores(buscarConductoresCiudad(conductores, ciudadOrigen));

                    //Pedirá al usuario que indique qué conductor va a realizar el viaje
                    System.out.print("Introduce el nombre del conductor: ");
                    nombreConductor = bufferedReader.readLine();

                    //Una vez hecho lo anterior, selecciona un autobús libre en la ciudad de origen.
                    mostrarAutobusesEstacion(estacionAutobuses, estacionAutobuses[buscarEstacion(estacionAutobuses, ciudadOrigen)].getNombreCiudad());

                    System.out.print("Introduce la numero del autobus: ");
                    matriculaBus = bufferedReader.readLine();

                    estacionOrigen = buscarEstacion(estacionAutobuses, ciudadOrigen);

                    autobusSeleccionado = estacionAutobuses[estacionOrigen].devuelvePosicionAutobusLibre();

                    estacionDestino = buscarEstacion(estacionAutobuses, ciudadDestino);

                    if (ciudadOrigen.equals("CORDOBA") && ciudadDestino.equals("JAEN"))
                    {

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
        if (estacionAutobuses != null) {
            for (int i = 0; i < estacionAutobuses.length; i++)
                if (estacionAutobuses[i].getNombreCiudad().equals(nombreEstacion))
                    return i;
        }

        return -1;
    }

    private static void mostrarAutobusesEstacion(EstacionAutobuses []estacionAutobuses, String nombreEstacion) {
        int posicionEstacion = -1;

        if (estacionAutobuses != null) {
            for (int i = 0; i < estacionAutobuses[i].getAutobusesEnAnden(); i++) {
                posicionEstacion = buscarEstacion(estacionAutobuses, nombreEstacion);
            }
            if (posicionEstacion != -1)
                estacionAutobuses[posicionEstacion].mostrarAutobuses();
            else
                System.out.println("No se encuentra la estacion " + nombreEstacion + "\n");
        }
    }

    private static Conductor [] buscarConductoresCiudad(Conductor []conductores, String nombreCiudad)
    {
        Conductor []listaConductores = null;
        int numeroConductores = 0;
        int contador = 0;
        int conductoresEncontrados = 0;

        if ( conductores != null && nombreCiudad != null )
        {
            //Calculamos el numero de conductores de esa ciudad
            for (int i = 0; i < conductores.length; i++)
                if (conductores[i].getCiudadAlojamiento().equals(nombreCiudad))
                    numeroConductores++;

            //Creamos un array de conductores de ese tamaño
            listaConductores = new Conductor[numeroConductores];

            //Guardamos en el array los conductores de esa ciudad
            do {
                if (conductores[contador].getCiudadAlojamiento().equals(nombreCiudad)) {
                    listaConductores[conductoresEncontrados] = conductores[contador];
                    conductoresEncontrados++;
                }
                contador++;
            } while (conductoresEncontrados < numeroConductores);
        }

        return listaConductores;
    }

    private static Conductor buscarConductorNombre(Conductor []conductores, String nombreConductor)
    {
        Conductor conductor = null;

        if (conductores != null && nombreConductor != null)
            for (Conductor conductorActual: conductores)
                if (conductorActual.getNombre().equals(nombreConductor))
                    conductor = conductorActual;

        return conductor;
    }


    private static void mostrarConductores(Conductor []conductores) {

        if (conductores != null)
            for (int i = 0; i < conductores.length; i++)
                System.out.println(conductores[i].devolverDatosConductor());
    }

    private static void reiniciarKilometrosTodosConductores(Conductor []conductores)
    {
        if (conductores != null)
            for (Conductor conductor: conductores)
            conductor.reiniciaKmMes();
    }
}