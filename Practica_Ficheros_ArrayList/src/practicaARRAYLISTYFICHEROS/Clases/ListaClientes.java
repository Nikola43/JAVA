package practicaARRAYLISTYFICHEROS.Clases;

/*
ListaClientes: esta clase tiene como atributo un arrayList de tipo Cliente, donde estarán
guardados todos los clientes fichados en la empresa de Rent a Car. El constructor vuelca de un
fichero llamado “clientes” todos los objetos que contiene al atributo ArrayList (si el fichero
está vacío o no existe, no pasa ningún objeto, evidentemente), mostrando un mensaje de éxito
en el paso al arrayList de los objetos o un mensaje de fracaso en caso de no poder pasarlo.
Otros métodos que contiene la clase ListaClientes son (hasta aquí 0.5 puntos):

 Métodos que permitan dar de alta y baja a clientes. El método que da el alta a los
clientes comprueba si el DNI del cliente no existe ya. En caso que no exista introduce al
cliente en el atributo arrayList de la clase por orden alfabético de apellidos y si son
iguales los apellidos, en orden alfabético del nombre. El método devuelve true si ha
podido dar de alta al cliente y false en caso contrario. Para la baja elimina al cliente a
partir de su DNI si este existe en el arrayList de clientes (es necesario hacer uso de un
iterador en caso de necesitar recorrer el arrayList de clientes). Devolverá true si ha
podido eliminar al cliente o false en caso de que no pueda. (0.5 puntos)

 esCliente(String DNI): devuelve true si el DNI pertenece a algún cliente y falso en caso
contrario. Es obligatorio el uso de iteradores para recorrer el arrayList. (0.25 puntos)

 toString(): reescribe el método de Object devolviendo una cadena con todos los datos
de los clientes que hay. Después de guardar los datos de un usuario debe separarse de
los datos del siguiente con un salto de línea. Al final, también debe concatenar
también el total de clientes que hay. Para recorrer el arrayList es necesario el uso de
iteradores. (0.25 puntos)

 mueveDatosAFichero(): mueve todos los datos del arrayList al fichero “clientes” (no
añade datos, sino que machaca el fichero). Devuelve mensajes en caso de éxito en
pasar los datos al fichero, de que haya un fallo o de que ocurra un error al cerrar el
fichero. Es necesario el uso de iteradores para recorrer el arrayList. (0.25 puntos)

 getCliente(String DNI): devuelve el cliente que se corresponde con el DNI pasado como
parámetro. Es necesario el uso de iteradores para recorrer el arrayList. (0.25 puntos)

 buscarYMostrarCliente: recibe como parámetro el DNI de un cliente y si existe muestra
los datos del cliente, en caso contrario muestra un mensaje indicando que el cliente no
existe en la aplicación. (0.25 puntos)

 listarClientes: no recibe ningún parámetro y muestra los datos de todos los clientes de
la aplicación. Es necesario el uso de iteradores para recorrer el arrayList. (0.25 puntos)
 */

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;

public class ListaClientes {
    //Atributos
    private ArrayList<Cliente> listaClientes;

    public ListaClientes(String nombreFichero) {
        File ficheroClientes = new File(nombreFichero);
        long longitudArrayClientesInicial = 0;
        long longitudArrayClientesFinal = 0;

        if (ficheroClientes.exists() || ficheroClientes.length() < 1) {
            //Calculamos el peso del fichero
            longitudArrayClientesInicial = listaClientes.size();

            //Introducimos los datos del fichero en el arraylist


            //Comprobamos si se pudo guardar el fichero en el arraylist
            longitudArrayClientesFinal = listaClientes.size();
            if (longitudArrayClientesFinal > longitudArrayClientesInicial)
                System.out.println("Se han insertado los clientes correctamente");
            else
                System.err.println("No se ha podido insertar los clientes");
        } else
            listaClientes = new ArrayList<>();
    }

    private boolean darAltaCliente(Cliente cliente) {
        boolean resultado = false;

        if (!esCliente(cliente.getDNI())) {
            listaClientes.add(cliente);

            //Ordenar
            //listaClientes.sort(cliente);

            resultado = true;
        }

        return resultado;
    }

    private boolean darBajaCliente(Cliente cliente) {
        boolean resultado = false;
        ArrayList<Cliente> aux = new ArrayList<>();
        Iterator<Cliente> itr = listaClientes.iterator();
        Cliente clienteAux;
        int longitudListaClientesInicial;
        int longitudListaClientesFinal;

        if (esCliente(cliente.getDNI())) {

            longitudListaClientesInicial = listaClientes.size();
            //Metemos en el array todos los elementos menos el que queremos borrar
            while (itr.hasNext()) {
                clienteAux = itr.next();
                if (!clienteAux.getDNI().equals(cliente.getDNI())) {
                    aux.add(clienteAux);
                }
            }
            listaClientes = aux;
            longitudListaClientesFinal = listaClientes.size();

            if (longitudListaClientesFinal < longitudListaClientesInicial)
                resultado = true;
        }

        return resultado;
    }

    private boolean esCliente(String dniCliente) {
        boolean resultado = false;
        Iterator<Cliente> itr = listaClientes.iterator();

        while (itr.hasNext() && !resultado) {
            if (itr.next().getDNI().equals(dniCliente))
                resultado = true;
        }

        return resultado;
    }

    @Override
    public String toString() {
        String texto = "";

        for (Cliente cliente : listaClientes)
            texto += cliente.toString() + "\n\n";

        return texto;
    }

    public void mueveDatosAFichero(String nombreFichero) {

        File fichero = new File(nombreFichero);
        FileOutputStream fileOutputStream = null;
        ObjectOutputStream objectOutputStream = null;

        try {
            fileOutputStream = new FileOutputStream(fichero);
            objectOutputStream = new ObjectOutputStream(fileOutputStream);

            //Escribimos los clientes
            for (Cliente cliente : listaClientes) {
                objectOutputStream.writeObject(cliente);
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
            else if (fichero.exists() && fichero.length() < 1)
                System.err.println("El fichero se ha creado y se han insertado los datos correctamente");
        }
    }

    public Cliente getCliente(String dniCliente){
        boolean resultado = false;
        Cliente clienteActual = null;
        Cliente clienteDevuelto = null;
        Iterator<Cliente> itr = null;

        //Si el cliente existe
        if (esCliente(dniCliente)){
            listaClientes.iterator();
            while (itr.hasNext()) {
                clienteActual = itr.next();
                if (clienteActual.getDNI().equals(dniCliente))
                    clienteDevuelto = clienteActual;
            }
        }
        return clienteDevuelto;
    }

    public void buscarYMostrarCliente(String dniCliente){
        //Si el cliente existe
        if (getCliente(dniCliente) != null)
            System.out.println(getCliente(dniCliente).toString());
        else
            System.out.println("No se encuentra el cliente");
    }

    public void listarClientes(){
        for (int i = 0; i < listaClientes.size(); i++) {
            System.out.println("-------------------------> Cliente Nº: "+i+" <----------------------------");
            System.out.println(listaClientes.get(i).toString());
            System.out.println("---------------------------------------------------------\n");
        }
    }


}
