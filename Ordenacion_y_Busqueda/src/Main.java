import java.util.Random;

public class Main {
    public static void main(String []args)
    {
        final int TAM = 100;

        int [] arrayDesordenado = new int[TAM];
        int [] arrayOrdenado;

        //Rellenamos el array con 100 numeros aleatorios
        for (int i = 0; i < arrayDesordenado.length; i++) {
            arrayDesordenado[i] =  randInt(1, 100);
        }

        imprimirArray(arrayDesordenado);

        arrayOrdenado = insercionSort(arrayDesordenado);

        imprimirArray(arrayOrdenado);
    }

    /*Ejercicio 2. Realiza un programa que cree dos vectores de 100 elementos. El primero almacenará
    una serie de datos numéricos desordenados. Dichos datos serán datos generados aleatoriamente.
    El segundo array contendrá los mismos datos pero ordenados por el método de inserción.*/
    private static int[] insercionSort(int []array)
    {
        int []arrayClon = array.clone(); // clonamos el array para no modificar el pasado por parametro (original)
        int tamanio = arrayClon.length;  // tamaño de la array a ordenar

        //Recorremos el array hasta el final empezando por la segunda posicion
        for ( int i = 1; i < tamanio; i++)
        {
            int elementoActual = arrayClon[i]; //extraemos el elemento
            int j = i - 1; // j será la posicion actual menos uno

            //Mientras j sea mayor que 0 Y el valor de la posicion j mayor que el elemento actual
            while (j >= 0 && arrayClon[j] > elementoActual)
            {
                //Intercambiamos elementos
                arrayClon[j+1] = arrayClon[j];
                j = j - 1;
            }
            //Se guarda el elemento actual en la siguiente posicion
            arrayClon[j+1] = elementoActual;
        }

        return (arrayClon);
    }

    private static int randInt(int min, int max)
    {
        return new Random().nextInt (max - min + 1) + min;
    }

    private static void imprimirArray(int []array)
    {
        for (int elementoActual: array)
            System.out.print(elementoActual + " ");

        System.out.println();
    }

    /*
    Ejercicio 1. Haz la traza de la ordenación del siguiente vector con los algoritmos de burbuja
    optimizada, inserción, selección y quicksort. ¿Cuantas iteraciones realiza cada uno?
    12 -4 1 0 3 7 15



    Ejercicio 3. Realiza un método que tome como parámetros de entrada dos arrays de enteros y
    devuelva como salida un único array con los elementos de los anteriores arrays ordenados de
    forma ascendente. Intenta hacerlo de la manera más eficiente posible. ¿Qué método de
    ordenación has usado?

    Ejercicio 4. Realiza un programa que cree 1000 números aleatorios y muestre los 10 mayores.

    Ejercicio 5. Realiza un programa que cree un vector de 100 posiciones con números aleatorios
    entre 1 y 100 (pueden repetirse). Una vez creado el vector el programa deberá mostrar los
    números entre 1 y 100 que no han sido almacenados. Indica qué algoritmo de ordenación has
    usado y qué algoritmo de búsqueda.

    Ejercicio 6. Realiza un programa que cree un vector de 100 posiciones con números aleatorios
    entre 10 y 80. Una vez creado el vector el programa deberá mostrar el mayor, el menor, el valor
    que más se repite y la media.

    Ejercicio 7. Crea una clase busquedabin la cual tenga un método que busque un valor en un
    array ordenado utilizando la búsqueda binaria. Implementa el método de tal manera que muestre
    las posiciones (min y max) desde las cuales va buscando y los valores de dichas posiciones así
    como la posición intermedia y el valor de dicha posición.
     */
}
