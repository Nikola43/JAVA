import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Iterator;

public class Main {

    public static void main(String[] args) {

        //Creamos un arrayList donde guardaremos los objetos que escribiremos en el fichero
        ArrayList<Vehiculo> vehiculosParaInsertarEnFichero = new ArrayList<Vehiculo>(); //-> Escritura

        //Creamos otro arrayList donde guardaremos los objetos que leemos del fichero
        ArrayList<Vehiculo> vehiculosLeidosDesdeFichero = new ArrayList<Vehiculo>(); //-> Lectura

        //Insertamos objetos en el array que luego escribiremos
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-31", "DCF-1", 6, true));
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-32", "DCF-2", 6, true));
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-33", "DCF-3", 6, true));
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-34", "DCF-4", 6, true));
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-35", "DCF-5", 6, true));
        vehiculosParaInsertarEnFichero.add(new Vehiculo("DFGDF-36", "DCF-6", 6, true));

        System.out.println("Insertando datos....");

        //Escribimos en el fichero
        if(escribirDatosFichero(vehiculosParaInsertarEnFichero))
            System.out.println("Se ha insertado correctamente\n");
        else
            System.err.println("No se ha podido insertar en el fichero\n");

        System.out.println("Leyendo datos....");
        //Leemos desde fichero
        vehiculosLeidosDesdeFichero = leerFichero("Fichero.dat");

        //Mostramos
        mostrarListaVehiculos(vehiculosLeidosDesdeFichero);
    }

    private static boolean escribirDatosFichero(ArrayList<Vehiculo> vehiculos) {
        boolean resultado = false;
        long longitudFicheroInicial = 0;
        long longitudFicheroFinal = 0;

        File fichero = new File("Fichero.dat");
        FileOutputStream fileOutputStream = null;
        ObjectOutputStream objectOutputStream = null;

        //Abrirmos el fichero
        try {
            //Primero comprobamos si el fichero existe
            if (!fichero.exists()) {
                //Si no existe lo abrimos como siempre
                fileOutputStream = new FileOutputStream(fichero);
                objectOutputStream = new ObjectOutputStream(fileOutputStream);
            } else {
                //Si ya existe abrimos el buffer usando MiObjectOutputStream para no sobrescribir la cabecera
                fileOutputStream = new FileOutputStream(fichero, true);
                objectOutputStream = new MiObjectOutputStream(fileOutputStream);
            }

            //Calculamos la longitud del fichero antes de añadir datos
            longitudFicheroInicial = fichero.length();

            //Recorremos el array y vamos escribiendo los datos en el fichero
            Iterator<Vehiculo> it = vehiculos.iterator();
            while (it.hasNext())
                objectOutputStream.writeObject(it.next());

            //Calculamos la longitud del fichero despues de añadir datos
            longitudFicheroFinal = fichero.length();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //Cerramos el fichero
            if (objectOutputStream != null) {
                try {
                    objectOutputStream.close();
                    fileOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        //Comprobamos si se ha escrito correctamente
        if (longitudFicheroFinal > longitudFicheroInicial)
            resultado = true;

        return resultado;
    }

    private static ArrayList<Vehiculo> leerFichero(String fichero) {
        //Para leer
        FileInputStream fileInputStream = null;
        ObjectInputStream objectInputStream = null;
        Vehiculo vehiculoAux;
        ArrayList<Vehiculo> listaVehiculos = new ArrayList<Vehiculo>();

        try {
            fileInputStream = new FileInputStream(fichero);
            objectInputStream = new ObjectInputStream(fileInputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }

        //Leemos
        try {
            while (true) {
                vehiculoAux = (Vehiculo) objectInputStream.readObject();
                listaVehiculos.add(vehiculoAux);
            }
        } catch (EOFException e) {
            System.err.println("ERROR I/O: Fin de fichero");
        } catch (ClassNotFoundException | IOException e) {
            e.printStackTrace();
        } finally {
            if (objectInputStream != null && fileInputStream != null) {
                try {
                    objectInputStream.close();
                    fileInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return listaVehiculos;
    }

    public static void mostrarListaVehiculos(ArrayList<Vehiculo> listaVehiculos){
        for (Vehiculo vehiculoActual: listaVehiculos) {
            System.out.println("--------------------------------------");
            System.out.println(vehiculoActual.toString());
        }
    }
}
