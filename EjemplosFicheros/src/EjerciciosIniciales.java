/*
4. Crea una función a la que se le pase como parámetro un número y elimine de un fichero que
tenga números primos dicho número. Ten en cuenta, que para hacerlo, necesitarás de un
fichero temporal.

5. Crea una función que cree un fichero con los siguientes datos de clientes: Nombre, Apellido,
Edad. La función pregunta cómo se tiene que llamar el fichero, y pide los datos hasta que el
usuario inserta la palabra Fin (en el primer campo que pide). La función devuelve true si ha
terminado de manera correcta y false en caso contrario, y además pide al usuario el nombre
que quiere ponerle al fichero.

Vamos a proceder a rellenar el fichero con los siguientes valores:
Juan    Palomez  35
Paloma  Sancho   19
Arturo  Coy      40
Noelia  Bravo    33
Pancho  Cancho   21

6. Crea una funcion mostrarClientes para que imprima por pantalla todos los registros de los
ficheros que tengan la estructura del fichero anterior.

7. La siguiente función deberá crear dos ficheros de clientes a partir de un fichero de clientes
pasado como parámetro. El programa meterá los datos en uno u otro fichero en función de si
la edad es menor o igual que la dada por el usuario o mayor que ésta respectivamente.

*/

import java.io.*;

public class EjerciciosIniciales {
    /*
    1. Crea una función a la que se le pase como parámetro una cadena, y genere un fichero de
    texto con el nombre de dicha cadena. La función debe rellenar un fichero con cadenas (en
    diferentes líneas) hasta que el usuario escriba la palabra “final”.
    */
    public static void main(String[] args) {

        //1
        String nombreFichero = "fichero.txt";
        //ej1(nombreFichero);

        //2
        //if (ej2(13))
        //    System.out.println("Se ha creado correctamente");

        ej3("test.txt");
    }

    private static void ej1(String nombreFichero) {

        String palabaActual = null;

        //Para leer el teclado
        BufferedReader bufferedReader = null;

        //Para escribir en el fichero
        File file = null;
        FileWriter fileWriter = null;
        BufferedWriter bufferedWriter = null;

        //Abrimos el fichero del teclado (Entrada estandar de java)
        bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Abrimos el fichero para escribir en el
        file = new File(nombreFichero);

        try {
            fileWriter = new FileWriter(file);
            bufferedWriter = new BufferedWriter(fileWriter);

            do {
                //leemos por teclado
                System.out.print("Introduce una palabra: ");
                try {
                    //Leemos una palabra
                    palabaActual = bufferedReader.readLine();

                    //Si el fichero se pudo abrir correctamente, escribimos
                    bufferedWriter.write(palabaActual);
                    bufferedWriter.newLine();

                } catch (IOException e) {
                    e.printStackTrace();
                }
            } while (!palabaActual.equals("final"));

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileWriter != null && bufferedWriter != null)
                try {
                    bufferedWriter.close();
                    fileWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
    }
    /*
        2. Crea un función a la que se le pase como parámetro un número num y genere un fichero que
        guarde los num primeros números primos (empezando desde el 2) en dicho fichero. La
        función devuelve true si ha terminado de manera correcta y false en caso contrario, y
        además pide al usuario el nombre que quiere ponerle al fichero.
        */

    private static boolean ej2(int num) {

        boolean resultado = false;
        String nombreFichero = null;
        long tamanioFicheroInicial = 0;
        long tamanioFicheroFinal = 0;

        //Para leer el teclado
        BufferedReader teclado = null;

        //Para escribir en el fichero
        File file = null;
        FileWriter fileWriter = null;
        BufferedWriter bufferedWriter = null;

        //Abrimos el fichero del teclado (Entrada estandar de java)
        teclado = new BufferedReader(new InputStreamReader(System.in));

        System.out.print("Introduce el nombre del fichero: ");
        try {
            nombreFichero = teclado.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //Abrimos el fichero para escribir en el
        file = new File(nombreFichero);
        tamanioFicheroInicial = file.length();
        try {
            fileWriter = new FileWriter(file);
            bufferedWriter = new BufferedWriter(fileWriter);

            for (int i = 2; i < num; i++) {
                if (numeroEsPrimo(i)) {
                    bufferedWriter.write(String.valueOf(i));
                    bufferedWriter.newLine();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileWriter != null && bufferedWriter != null)
                try {
                    bufferedWriter.close();
                    fileWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }

        //Calculamos el tamaño del fichero al final de la escritura
        tamanioFicheroFinal = file.length();

        //Comprobamos si se ha escrito correctamente
        if (tamanioFicheroFinal > tamanioFicheroInicial)
            resultado = true;

        return resultado;
    }

    /*3. Crea una función que imprima por consola cualquier fichero generado con la función
    anterior.*/
    private static void ej3(String nombreFichero) {
        String lineaActual = null;

        //Para escribir en el fichero
        File file = null;

        //Para leer del fichero
        FileReader fileReader = null;
        BufferedReader bufferedReader = null;


        file = new File(nombreFichero);

        //Leemos
        if (file.exists() && file.canRead()) {
            try {
                fileReader = new FileReader(file);
                bufferedReader = new BufferedReader(fileReader);

                do {
                    lineaActual = bufferedReader.readLine();
                    if (lineaActual != null)
                        System.out.println(lineaActual);
                } while (lineaActual != null);

            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (fileReader != null && bufferedReader != null)
                    try {
                        bufferedReader.close();
                        fileReader.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        } else {
            System.out.println("El fichero no existe");
        }
    }

    private static boolean numeroEsPrimo(int n) {
        boolean esPrimo = true;

        //Si el numero es 1, 0 o negativo no se considera primo
        if (n <= 1)
            esPrimo = false;

        for (int i = 2; i <= (n / 2) && esPrimo; i++) {
            if (n % i == 0) {
                esPrimo = false;
            }
        }
        return esPrimo;
    }
}



