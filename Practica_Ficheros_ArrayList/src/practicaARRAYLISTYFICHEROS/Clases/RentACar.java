package practicaARRAYLISTYFICHEROS.Clases;

import java.io.*;
import java.util.ArrayList;

/*
RentACar: contiene como atributos el nombre de la empresa de Rent a Car, un objeto tipo
ListaClientes, otro objeto tipo ListaVehiculos y un ArrayList de objetos Alquiler.

 El constructor recibe como parámetro el nombre del rent a car el cual se lo asigna al
atributo correspondiente, crea el objeto ArrayList para alquileres, crea los objetos
para los atributos ListaClientes y ListaVehiculos e inserta los alquileres del fichero
correspondiente (con el método que definiremos a continuación).
(hasta aquí 0.25 puntos)

 insertaAlquileresDelFichero: Inserta en el atributo arrayList de alquileres objetos
Alquiler a partir de un fichero “alquileres”. Debe mostrar un mensaje en caso de que
el volcado se realice con éxito, o en caso que haya ocurrido un error o en caso que la
clase Alquiler no se haya encontrado. Si ocurre un error durante el cierre del fichero
alquileres también debe mostrar un mensaje de error. Igualmente si no existe el
fichero alquileres se lo hace saber al usuario. (0.25 puntos)

 creaCliente(): pide al usuario los datos del cliente y le da de alta en el objeto
ListaCliente. Si se llevó a cabo el alta correctamente se lo hace saber al usuario. Si ha
habido algún problema muestra un mensaje de error en la inserción.

 borraCliente(): pide al usuario el DNI del cliente a eliminar y le da de baja. Además,
borrará del arrayList tipo Alquiler los alquileres llevados a cabo por dicho cliente,
poniendo a disponibles todos los vehículos que tenía alquilados (sin cobrarle nada). Es
obligatorio el uso de iteradores para TODOS los Arraylist que se usen dentro del
método. Se mostrarán mensajes en caso de éxito o fracaso borrando al cliente.
(0.5 puntos)

 buscarCliente(): pide al usuario del DNI del cliente y muestra los datos de dicho cliente.

 anyadirVehiculoALaFlota(): pregunta al usuario si el vehículo a insertar va a ser un
coche o una furgoneta. Pide los datos al usuario del nuevo vehículo, y le da de alta. Si
el alta se lleva a cabo con éxito muestra un mensaje, de la misma manera en caso
contrario. (0. 25 puntos)

 bajaVehiculo (): pide al usuario la matrícula del vehículo a dar de baja. Si se le da de
baja al vehículo con éxito muestra un mensaje, igualmente si no se puede dar de baja
al vehículo también mostrará un mensaje. (0.25 puntos)

 realizarAlquiler(): pide el DNI del cliente y la matrícula del vehículo que quiere alquilar.
Si el cliente y el vehículo existen comprueba si el cliente ya tiene alquileres, en caso de
que los tenga, añade el vehículo a los alquileres de dicho cliente y pone el vehículo a
ocupado. Muestra un mensaje indicando que el vehículo ha sido alquilado con éxito.
En caso de que el cliente no tuviera alquileres, crea un nuevo objeto alquileres para
dicho cliente y añade el vehículo a dicho alquiler mostrando un mensaje. Es
obligatorio el uso de iteradores para recorrer ArrayList. (0.5 puntos)

 devolucionAlquiler(): pide el DNI del cliente y la matrícula del vehículo a devolver. Si el
cliente y el vehículo existen, comprueba que el cliente tiene Alquiler pendiente y en
caso que lo tenga si la matrícula dada está en los alquileres de dicho cliente. Si es así,
devuelve el vehículo, si la lista de vehículos alquilados del cliente está vacía, borra el
objeto Alquiler perteneciente al cliente del arrayList de alquileres. También gestiona
el coste del alquiler para mostrar al usuario, pone el vehículo a disponible. Es
obligatorio el uso de iteradores, además se deben mostrar mensajes en caso de éxito
o fracaso en la gestión. (0.5 puntos)

 muestraPrestamosCliente(String dni): si el cliente existe, muestra los datos del cliente,
y en caso de tener alquileres, muestra las matrículas de los vehículos alquilados (si no
tiene alquileres muestra un mensaje indicando que no tiene alquileres). Es necesario
el uso de iteradores para recorrer los arrayList correspondientes. (0. 5 puntos)

 getListaClientes() y getListaVehiculos() : devuelven respectivamente el atributo
ListaClientes y el atributo ListaVehiculos.

 cerrarAplicacion(): mueve los datos de los clientes al fichero “clientes”, los datos de los
vehículos al fichero “vehículos” y los datos de los alquileres al fichero “alquileres”
mostrando los mensajes correspondientes en casos de error o éxito. (0.5 puntos)
 */
public class RentACar {
    //Atributos
    private String nombreEmpresa;
    private ListaClientes listaClientes;
    private ListaVehiculos listaVehiculos;
    private ArrayList<Alquiler> alquileres;

    //Constructores
    public RentACar(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
        alquileres = new ArrayList<>();
        listaClientes = new ListaClientes();
        listaVehiculos = new ListaVehiculos();

    }

    //Metodos añadidos
    public void creaCliente() {
        String dni = null, nombre = null, apellidos = null;
        boolean resultado;

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        try {
            System.out.print("Introduce el dni: ");
            dni = bufferedReader.readLine();
            System.out.print("Introduce el nombre: ");
            nombre = bufferedReader.readLine();
            System.out.print("Introduce los apellidos: ");
            apellidos = bufferedReader.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        resultado = listaClientes.darAltaCliente(new Cliente(dni, nombre, apellidos));

        if (resultado)
            System.out.println("Se ha introducido el cliente correctamente");
        else
            System.out.println("No se ha introducido el cliente");
    }

    public void borrarCliente() {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

    }

    public void insertaAlquileresDelFichero() {
        //Para leer
        File fichero;
        FileInputStream fileInputStream = null;
        ObjectInputStream objectInputStream = null;
        Alquiler alquilerAux;
        int longitudAlquileresInicial = 0;
        int longitudAlquileresFinal = 0;


        fichero = new File("alquileres.dat");
        longitudAlquileresInicial = alquileres.size();

        if (!fichero.exists()) {
            System.out.println("El fichero no existe");
        } else {
            try {
                fileInputStream = new FileInputStream(fichero);
                objectInputStream = new ObjectInputStream(fileInputStream);

                alquilerAux = (Alquiler) objectInputStream.readObject();
                while (alquilerAux != null) {
                    alquileres.add(alquilerAux);
                    alquilerAux = (Alquiler) objectInputStream.readObject();
                }
            } catch (EOFException e) {
                System.err.println("ERROR I/O: Fin de fichero");
            } catch (ClassNotFoundException | IOException e) {
                e.printStackTrace();
            } finally {
                if (objectInputStream != null) {
                    try {
                        objectInputStream.close();
                        fileInputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                longitudAlquileresFinal = alquileres.size();

                if (longitudAlquileresFinal > longitudAlquileresInicial)
                    System.out.println("Se ha insertado correctamente");
            }
        }
    }
}

