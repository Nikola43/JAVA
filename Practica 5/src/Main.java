import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Hashtable;
import java.util.Random;

public class Main {

    //todas las palabras disponibles para el juego
    public static String matrizPalabras[][] = {
            {"perro","calle","angosto","ruido","perdiz","jamon","eustaquio","arrea","canijo","ruta"},
            {"paz","enjuagar","apartamento","estrella","huevo","canto","puya","torrezno","babas","papel"},
            {"peces","casting","kiwi","tortola","atun","desde","osa","quinque","vitola","alcancia"},
            {"lado","timpano","gargara","amor","orquilla","taimado","pintura","manzano","caño","añejo"},
            {"tuit","horas","cuenca","letal","foco","ovulo","retiro","esencia","ion","juez"},
            {"kiko","montaña","nevera","oreja","pituitaria","suave","uretra","yodo","este","oligarca"},
            {"atuendo","coral","efecto","korea","espada","guinda","gato","tacon","alegrias","rodaja"},
            {"faena","jactar","rayo","corcho","ballena","lomo","ameba","dique","rito","vector"},
            {"salado","gracia","octava","piraña","gnomo","uva","traje","lima","boton","resta"},
            {"garbanzo","pastel","zoleta","erosion","magma","litoral","botin","ralo","faro","aguijon"}};


    // indican el tamaño del tablero
    static final int FILAS = 8,  COLUMNAS = 8;

    //vector con los puntos que tendrá cada letra (excepto la ñ) de las palabras que colocamos en el tablero.
    static int puntosLetras[] = {1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,4,4,4,3};

    //Hastable para hacer un enlace entre los puntos que valen las letras
    static Hashtable hashtablePuntosLetras = crearHashtablePuntosLetras();

    //variables tipo entero para guardar los puntos acumulados por cada jugador.
    static int puntosJugador1 = 0, puntosJugador2 = 0;

    //será tipo entero y marcará a qué jugador le toca jugar (valdrá 1 cuando le toque al jugador 1 y 2 cuando le toque al jugador2).
    static int turno = 1;

    //se guardarán las palabras que tendrácada jugador para insertarlas en el tablero.
    static String []palabrasJugador1, palabrasJugador2;

    static int numeroPalabrasJugador1, numeroPalabrasJugador2;

    //tablero. El tamaño del tablero lo marca FILAS y COLUMNAS.
    static char [][]tablero = new char[FILAS][COLUMNAS];

    static boolean rendirse = false;
    
    public static void main(String []Args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        int palabraSeleccionada, filaSeleccionada, columnaSeleccionada;
        char posicionPalabra;

        //Mostramos mensaje de bienvenida
        System.out.println("Bienvenido al juego apalabrados, !Espero que tenga una partida muy divertida¡\n\nCOMIENZA EL JUEGO");

        //Generamos las palabras para cada jugador
        palabrasJugador1 = repartePalabras(5);
        palabrasJugador2 = repartePalabras(5);

        numeroPalabrasJugador1 = palabrasJugador1.length;
        numeroPalabrasJugador2 = palabrasJugador2.length;

        //Generamos y mostramos el tablero
        tablero = creaTablero();
        muestraTablero(tablero);

        //Mientras ningún jugador se quede sin palabras o se rinda el juego continuará.
        while (numeroPalabrasJugador1 > 1 && numeroPalabrasJugador2 > 1 && !rendirse)
        {
            //Mostramos el turno del jugador al que le toca en cada momento
            System.out.println("TURNO JUGADOR "+turno);

            //Mostramos las palabras de los lugadores segun el turno
            System.out.println("\nPalabras jugador "+turno);
            if ( turno == 1 )
                muestraMisPalabras(palabrasJugador1);

            if ( turno == 2 )
                muestraMisPalabras(palabrasJugador2);

            System.out.println("Indica el numero de la palabra que quieres colocar(1-5): ");
            palabraSeleccionada = Integer.parseInt(bufferedReader.readLine());

            System.out.println("Indica la fila donde la quieres colocar(1-8): ");
            filaSeleccionada = Integer.parseInt(bufferedReader.readLine());

            System.out.println("Indica la columna donde la quieres colocar(1-8): ");
            columnaSeleccionada = Integer.parseInt(bufferedReader.readLine());

            System.out.println("Indica como quiere colocar la palabra Vertical (V) Horizontal (H): ");
            posicionPalabra = bufferedReader.readLine().charAt(0);

            if ( turno == 1 )
                if ( puedoColocarPalabra(tablero, palabrasJugador1, palabraSeleccionada - 1, filaSeleccionada - 1, columnaSeleccionada - 1, posicionPalabra))
                {
                    colocarPalabra(tablero, palabrasJugador1, palabraSeleccionada - 1, filaSeleccionada - 1, columnaSeleccionada - 1, posicionPalabra);
                    muestraTablero(tablero);
                    numeroPalabrasJugador1--;
                }
            if ( turno == 2 )
                if ( puedoColocarPalabra(tablero, palabrasJugador2, palabraSeleccionada, filaSeleccionada, columnaSeleccionada, posicionPalabra))
                {
                    colocarPalabra(tablero, palabrasJugador2, palabraSeleccionada - 1, filaSeleccionada - 1, columnaSeleccionada - 1, posicionPalabra);
                    muestraTablero(tablero);
                    numeroPalabrasJugador2--;
                }
            if ( turno == 1 )
                turno = 2;
            else
                turno = 1;

        }

    }

    //He decidido crear un hastable para enlazar las letras con los puntos que vale
    //Creo que hace mas facil la programacion de funciones futuras
    //Asi cuando tenga una palabra de un jugador y quiera saber cuantos puntos tienen las letras de esa palabra
    //Busco por la key y me da cuando vale cada letra
    static Hashtable crearHashtablePuntosLetras()
    {
        Hashtable hashtable = new Hashtable();
        int c = 0;

        //Creamos el hastable asociando de la a-z con los puntos correspondientes
        for (char i = 'a'; i <= 'z'; i++) {
            hashtable.put(i, puntosLetras[c]);
            c++;
        }
        return hashtable;
    }

    //crearTablero, que no se le pasan parámetros y devuelve una matriz tipo carácter con el
    //tamaño marcado por FILAS y COLUMNAS relleno de asteriscos.
    static char[][] creaTablero()
    {
        //definimos el tablero
        char [][] tableroGenerado = new char[FILAS][COLUMNAS];

        //Rellenamos el tablero con asteriscos
        for (int i = 0; i <tableroGenerado.length; i++)
            for (int j = 0; j < tableroGenerado[i].length; j++)
                tableroGenerado[i][j] = '*';

        return tableroGenerado;
    }

    //se le pasa como parámetro una matriz de caracteres y muestra
    //los números de cada fila y columna y el contenido que hay en cada posición.
    static void muestraTablero(char [][]tablero)
    {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int i = 0; i < tablero.length; i++) {
            System.out.print(i+" ");
            for (int j = 0; j < tablero[i].length; j++) {
                System.out.print(tablero[i][j] + " ");
            }
            System.out.println();
        }
    }

    //no recibe ningún parámetro y debe devolver una posición ALEATORIA (posición de fila y posición de columna)
    //de la matriz matrizPalabras que contenga una palabra (se entiende que cuando no hay una palabra en esa posición estará la cadena “XXXXX”).
    static int[] buscaCeldaNoVaciaRecursiva()
    {
        Random random = new Random();
        int []posicion = new int[2];
        int posicionI;
        int posicionJ;

        //generamos una posicion aleatoria
        posicionI = random.nextInt((matrizPalabras.length - 1) + 1);
        posicionJ = random.nextInt((matrizPalabras.length - 1) + 1);

        //Si en esa posicion no hay XXXXX guardamos esa posicion que mas tarde devolveremos
        if ( !matrizPalabras[posicionI][posicionJ].equals("XXXXX") )
        {
            posicion[0] = posicionI;
            posicion[1] = posicionJ;
        }
        else
        {
            buscaCeldaNoVaciaRecursiva();
        }

        return posicion;
    }

    //recibe como parámetro un entero con el número de palabras a repartir
    // y devuelve un vector de cadenas que contendrá tantas palabras como marque
    //el parámetro. Las palabras las tomará de manera aleatoria de matrizPalabras y cada
    //vez que tome una palabra de esa matriz, pondrá en la posición donde estaba esa
    //palabra la cadena “XXXXX”.
    static String [] repartePalabras(int numeroPalabrasRepartir)
    {
        //Vector con tantas posiciones de memoria segun el parametro
        String [] palabrasRepartidas = new String[numeroPalabrasRepartir];

        //Vector para la posicon de la palabra actual
        int [] posicionPalabra;

        //recorremos hasta rellenar el vector palabrasRepartidas
        for (int i = 0; i < palabrasRepartidas.length; i++)
        {
            //Buscamos una posicion que no tenga "XXXXX"
            posicionPalabra = buscaCeldaNoVaciaRecursiva();

            //Guardamos la palabra que hay en esa posicion en el vector de palabras repartidas
            palabrasRepartidas[i] = matrizPalabras[posicionPalabra[0]][posicionPalabra[1]];

            //Como ya hemos extraido la palabra de esa posicion ahora en esa posicion insertamos "XXXXX"
            matrizPalabras[posicionPalabra[0]][posicionPalabra[1]] = "XXXXX";
        }

        return palabrasRepartidas;
    }

    //recibe como parámetro un vector de cadenas y ordena de
    //manera recursiva dicho vector.
    // Return minimum index
    // Return minimum index
    static int minIndex(String a[], int i, int j)
    {
        if (i == j)
            return i;

        // Find minimum of remaining elements
        int k = minIndex(a, i + 1, j);

        // Return minimum of current and remaining.
        return (a[i].compareTo(a[k]) < 0) ? i : k;
    }

    // Recursive selection sort. n is size of a[] and index
    // is index of starting element.
    static void ordenaPalabrasRec(String a[], int n, int index)
    {
        String temp;

        // Return when starting and size are same
        if (index == n)
            return;

        // calling minimum index function for minimum index
        int k = minIndex(a, index, n-1);

        // Swapping when index nd minimum index are not same
        if (k != index){
            // swap
            temp = a[k];
            a[k] = a[index];
            a[index] = temp;
        }
        // Recursively calling selection sort function
        ordenaPalabrasRec(a, n, index + 1);
    }
    //que recibe como parámetro un vector de cadenas, lo ordena y
    //una vez ordenado muestra las palabras que contiene el vector y la posición donde están
    static void muestraMisPalabras(String [] misPalabras)
    {
        //Ordenamos
        //ordenaPalabrasRec(misPalabras, misPalabras.length, 0);

        //Mostramos
        for (int i = 0; i < misPalabras.length; i++)
            System.out.print("PALABRA" + i + ": " + misPalabras[i]+" ");
        System.out.println();
    }



    static boolean puedoColocarPalabra(char [][] tablero, String [] palabrasJugador, int posicionPalabraJugador, int posicionI, int posicionJ,char vertical_horizontal)
    {
        boolean sePuedeColocar = true;

        // FALSE - En la posición que se le pasa como parámetro para el vector del jugador se encuentra la cadena vacía.
        if ( palabrasJugador[posicionPalabraJugador].length() < 1 )
            sePuedeColocar = false;

        // FALSE - Si la palabra no cabe porque se salga del tablero (ya sea horizontal o vertical).
        if ( vertical_horizontal == 'V')
            if ( palabrasJugador[posicionPalabraJugador].length() > (FILAS - posicionI) )
                sePuedeColocar = false;

        if ( vertical_horizontal == 'H')
            if ( palabrasJugador[posicionPalabraJugador].length() > (COLUMNAS - posicionJ) )
                sePuedeColocar = false;

        // FALSE - Si la palabra que queremos colocar no se puede porque no coincide la letra en una
        //posición determinada con una palabra ya colocada. Por ejemplo, si quiero colocar
        //la palabra “bar” en esta situación de tablero:

        return sePuedeColocar;
    }

    // que tiene como parámetros el tablero, el vector del jugador, la posición
    //en el vector del jugador de la palabra que quiere colocar el jugador, la fila y la columna
    //en la matriz tablero donde la quiere colocar y la colocación (‘H’ para colocarla
    //horizontalmente y ‘V’ para colocarla verticalmente).
    static boolean colocarPalabra(char [][] tablero, String [] palabrasJugador, int posicionPalabraJugador, int posicionI, int posicionJ,char vertical_horizontal)
    {
        boolean sePuedeColocar = true;

        //comprobará si puede colocar la palabra o no
        if (puedoColocarPalabra(tablero, palabrasJugador, posicionPalabraJugador, posicionI, posicionJ, vertical_horizontal))
        {
            //VERTICAL
            if ( vertical_horizontal == 'V' )
            {
                for (int i = posicionI; i < palabrasJugador[posicionPalabraJugador].length(); i++)
                {
                    tablero[i][posicionJ] = palabrasJugador[posicionPalabraJugador].charAt(i);

                    if ( turno == 1 )
                        puntosJugador1 += tablero[i][posicionJ] == 'ñ' ? 3 : (int) hashtablePuntosLetras.get(tablero[i][posicionJ]);

                    if ( turno == 2 )
                        puntosJugador2 += tablero[i][posicionJ] == 'ñ' ? 3 : (int) hashtablePuntosLetras.get(tablero[i][posicionJ]);
                }
            }

            if ( vertical_horizontal == 'H' )
            {
                //HORIZONTAL
                for (int j = posicionJ; j < palabrasJugador[posicionPalabraJugador].length(); j++)
                {
                    tablero[posicionI][j] = palabrasJugador[posicionPalabraJugador].charAt(j);

                    if ( turno == 1 )
                        puntosJugador1 += tablero[posicionI][j] == 'ñ' ? 3 :  (int) hashtablePuntosLetras.get(tablero[posicionI][j]);

                    if ( turno == 2  )
                        puntosJugador2 += tablero[posicionI][j] == 'ñ' ? 3 :  (int) hashtablePuntosLetras.get(tablero[posicionI][j]);
                }
            }

            palabrasJugador[posicionPalabraJugador] = "";
        }
        else
            sePuedeColocar = false;

        return sePuedeColocar;
    }
}