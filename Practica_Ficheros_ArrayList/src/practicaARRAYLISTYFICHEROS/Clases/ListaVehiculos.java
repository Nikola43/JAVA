package practicaARRAYLISTYFICHEROS.Clases;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;

/*
ListaVehiculos: esta clase tiene como atributo un arrayList de tipo Vehiculo, donde estarán
guardados todos los vehículos registrados en la empresa de Rent a Car. El constructor vuelca
de un fichero llamado “vehiculos” todos los objetos que contiene al atributo ArrayList (si el
fichero está vacío o no existe, no pasa ningún objeto, evidentemente), mostrando un mensaje
de éxito en el paso al arrayList de los objetos o un mensaje de fracaso en caso de no poder
pasarlo. Otros métodos que contiene la clase ListaVehiculos son (hasta aquí 0.25 puntos):

 alta: recibe como parámetro un objeto tipo Vehiculo, si la matrícula del vehículo ya se
encuentra registrada en el arrayList devuelve FALSE, en caso contrario, inserta el
vehículo y devuelve true. (0.25 puntos)

 existeVehiculo: devuelve true o false en caso que el vehículo exista en la lista de
vehíciulos. Es necesario el uso de iteradores para recorrer el arrayList.

 baja: se le pasa como parámetro una matrícula y en caso que exista y no esté
alquilado, lo elimina y devuelve true. Si el vehículo no existe en la lista o está alquilado
a algún cliente, devolverá false. Es necesario el uso de iteradores para recorrer el
arrayList. (0.25 puntos)

 toString(): pregunta al usuario por la matrícula del vehículo. Busca dicho vehículo
(haciendo uso de iteradores) y si lo encuentra guarda en la cadena que devuelve los
datos del vehículo precedido de “EL VEHÍCULO ES UN COCHE” o “EL VEHÍCULO ES UNA
FURGONETA” según el tipo de vehículo que sea. Si el vehículo con esa matrícula no
existe, devuelve una cadena indicando que el vehículo no existe.

 getVehiculo: devuelve el objeto Vehiculo que corresponde con la matrícula pasada
como parámetro. Si no lo encuentra, devuelve null. Es necesario el uso de iteradores
para recorrer el arrayList.

 mueveDatosAFichero():mueve todos los datos del arrayList al fichero “vehiculos” (no
añade datos, sino que machaca el fichero). Devuelve mensajes en caso de éxito en
pasar los datos al fichero, de que haya un fallo o de que ocurra un error al cerrar el
fichero. Es necesario el uso de iteradores para recorrer el arrayList (0.25 puntos)

 listarVehiculos: no recibe parámetros. Pregunta al usuario si quiere listar todos los
vehículos, sólo los coches o solo las furgonetas. Muestra los datos correspondientes en
función de la decisión del usuario. (0.25 puntos)
 */
public class ListaVehiculos {
    //Atributos
    private ArrayList<Vehiculo> listaVehiculos;

    //Constructores
    public ListaVehiculos(String nombreFichero) {
        File ficheroVehiculos = new File(nombreFichero);
        long longitudArrayVehiculoInicial = 0;
        long longitudArrayVehiculoFinal = 0;

        if (!ficheroVehiculos.exists() || ficheroVehiculos.length() < 1) {
            System.out.println("El fichero no existe o esta vacio");
        } else {
            //Calculamos el peso del fichero
            longitudArrayVehiculoInicial = listaVehiculos.size();

            //Introducimos los datos del fichero en el arraylist
            introduceDatosEnArray(nombreFichero);

            //Comprobamos si se pudo guardar el fichero en el arraylist
            longitudArrayVehiculoFinal = listaVehiculos.size();
            if (longitudArrayVehiculoFinal > longitudArrayVehiculoInicial)
                System.out.println("Se han insertado los clientes correctamente");
            else
                System.err.println("No se ha podido insertar los clientes");
        }
    }

    //Metodos añadidos
    public boolean alta(Vehiculo vehiculo){
        boolean resultado = false;

        if (!existeVehiculo(vehiculo.getMatricula())) {
            listaVehiculos.add(vehiculo);

            //Ordenar
            //listaVehiculos.sort(vehiculo);

            resultado = true;
        }

        return resultado;
    }

    public boolean existeVehiculo(String matriculaVehiculo){
        boolean resultado = false;
        Iterator<Vehiculo> itr = listaVehiculos.iterator();

        while (itr.hasNext() && !resultado) {
            if (itr.next().getMatricula().equals(matriculaVehiculo))
                resultado = true;
        }

        return resultado;
    }

    public boolean baja(Vehiculo vehiculo){
        boolean resultado = false;
        ArrayList<Vehiculo> aux = new ArrayList<>();
        Iterator<Vehiculo> itr = listaVehiculos.iterator();
        Vehiculo vehiculoAux;
        int longitudListaVehiculosInicial;
        int longitudListaVehiculosFinal;

        if (existeVehiculo(vehiculo.getMatricula())) {

            longitudListaVehiculosInicial = listaVehiculos.size();
            //Metemos en el array todos los elementos menos el que queremos borrar
            while (itr.hasNext()) {
                vehiculoAux = itr.next();
                if (!vehiculoAux.getMatricula().equals(vehiculo.getMatricula())) {
                    aux.add(vehiculoAux);
                }
            }
            listaVehiculos = aux;
            longitudListaVehiculosFinal = listaVehiculos.size();

            if (longitudListaVehiculosFinal < longitudListaVehiculosInicial)
                resultado = true;
        }

        return resultado;
    }



    public Vehiculo getVehiculo(String matriculaVehiculo) {
        Vehiculo vehiculoActual = null;
        Vehiculo vehiculoDevuelto = null;
        Iterator<Vehiculo> itr = null;

        //Si el cliente existe
        if (existeVehiculo(matriculaVehiculo)){
            listaVehiculos.iterator();
            while (itr.hasNext()) {
                vehiculoActual = itr.next();
                if (vehiculoActual.getMatricula().equals(matriculaVehiculo))
                    vehiculoDevuelto = vehiculoActual;
            }
        }
        return vehiculoDevuelto;
    }

    @Override
    public String toString() {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        String matricula = null;
        String texto = null;
        Vehiculo vehiculoAux = null;

        //Preguntamos al usuario por la matricula del vehiculo
        System.out.print("Introduzca la matricula del vehiculo: ");
        try {
            matricula = bufferedReader.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        vehiculoAux = getVehiculo(matricula);

        if (vehiculoAux != null){
            if (vehiculoAux instanceof Coche)
                texto = "EL VEHICULO ES UN COCHE\n";
            if (vehiculoAux instanceof Furgoneta)
                texto = "EL VEHICULO ES UNA FURGONETA\n";

            texto += vehiculoAux.toString();
        }

        return texto;
    }

    public void introduceDatosEnArray(String nombreFichero){
        File fichero = new File(nombreFichero);
        FileInputStream fileInputStream = null;
        ObjectInputStream objectInputStream = null;
        Vehiculo vehiculoAux = null;
        long longitudArrayVehiculoInicial = 0;
        long longitudArrayVehiculoFinal = 0;

        longitudArrayVehiculoInicial = listaVehiculos.size();

        try {
            fileInputStream = new FileInputStream(fichero);
            objectInputStream = new ObjectInputStream(fileInputStream);

            try {
                vehiculoAux = (Vehiculo) objectInputStream.readObject();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            while ( vehiculoAux != null){
                listaVehiculos.add(vehiculoAux);
                vehiculoAux = (Vehiculo) objectInputStream.readObject();
            }
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        finally {
            //Cerramos el fichero
            if (objectInputStream != null){
                try {
                    objectInputStream.close();
                    fileInputStream.close();
                } catch (IOException e) {
                    System.err.println("Error I/O: No se pudo leer del fichero");
                    e.printStackTrace();
                }
            }

            //Comprobamos si se pudo guardar el fichero en el arraylist
            longitudArrayVehiculoFinal = listaVehiculos.size();
            if (longitudArrayVehiculoFinal > longitudArrayVehiculoInicial)
                System.out.println("Se han insertado los vehiculos correctamente");
            else
                System.err.println("No se ha podido insertar los vehiculos");

        }
    }

    public void mueveDatosAFichero(String nombreFichero) {

        File fichero = new File(nombreFichero);
        FileOutputStream fileOutputStream = null;
        ObjectOutputStream objectOutputStream = null;

        try {
            fileOutputStream = new FileOutputStream(fichero);
            objectOutputStream = new ObjectOutputStream(fileOutputStream);

            //Escribimos los clientes
            for (Vehiculo vehiculo : listaVehiculos) {
                objectOutputStream.writeObject(vehiculo);
            }

        } catch (IOException e) {
            System.err.println("Error I/O: No se pudo abrir el fichero");
            e.printStackTrace();
        }
        finally {
            //Cerramos el fichero
            if (objectOutputStream != null){
                try {
                    objectOutputStream.close();
                    fileOutputStream.close();
                } catch (IOException e) {
                    System.err.println("Error I/O: No se pudo escribir en el fichero");
                    e.printStackTrace();

                }
            }

            //Comprobamos si el fichero se ha creado correctamente
            if (fichero.exists())
                System.out.println("Fichero creado correctamente");
            else if (!fichero.exists())
                System.err.println("No se ha podido crear el fichero");
            else if (fichero.exists() && fichero.length() < 1)
                System.err.println("El fichero se ha creado pero no se ha podido escribir en el");
            else if (fichero.exists() && fichero.length() > 0)
                System.err.println("El fichero se ha creado y se han insertado los datos correctamente");
        }
    }

    public void listarVehiculos(){
        for (int i = 0; i < listaVehiculos.size(); i++) {
            System.out.println("-------------------------> Vehiculo Nº: "+i+" <----------------------------");
            System.out.println(listaVehiculos.get(i).toString());
            System.out.println("--------------------------------------------------------------------------\n");
        }
    }

    public int size(){
        return listaVehiculos.size();
    }
}
