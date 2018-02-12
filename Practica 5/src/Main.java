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
    public static final int FILAS = 8,  COLUMNAS = 8;

    //vector con los puntos que tendrá cada letra (excepto la ñ) de las palabras que colocamos en el tablero.
    public static int puntosLetras[] = {1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,4,4,4,3};

    //variables tipo entero para guardar los puntos acumulados por cada jugador.
    public static int puntosJugador1 = 0, puntosJugador2 = 0;

    //será tipo entero y marcará a qué jugador le toca jugar (valdrá 1 cuando le toque al jugador 1 y 2 cuando le toque al jugador2).
    int turno = 1;

    //se guardarán las palabras que tendrácada jugador para insertarlas en el tablero.
    String []jugador1, jugador2;

    //tablero. El tamaño del tablero lo marca FILAS y COLUMNAS.
    static char [][]tablero = new char[FILAS][COLUMNAS];
    
    public static void main(String []Args)
    {
        tablero = creaTablero();
        muestraTablero(tablero);
        System.out.println(buscaCeldaNoVaciaRecursiva());
    }

    //crearTablero, que no se le pasan parámetros y devuelve una matriz tipo carácter con el
    //tamaño marcado por FILAS y COLUMNAS relleno de asteriscos.
    public static char[][] creaTablero()
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
    public static void muestraTablero(char [][]tablero)
    {
        for (int i = 0; i < tablero.length; i++) {
            for (int j = 0; j < tablero[i].length; j++) {
                System.out.print(tablero[i][j] + " ");
            }
            System.out.println();
        }
    }

    //debe debe devolver una posición de la matriz matrizPalabras que contenga una palabra (se
    //entiende que cuando no hay una palabra en esa posición estará la cadena “XXXXX”).
    public static int[] buscaCeldaNoVaciaRecursiva()
    {
        Random random = new Random();
        int []posicion = new int[2];
        int posicionI;
        int posicionJ;

        //generamos una posicion aleatoria
        posicionI = random.nextInt((matrizPalabras.length - 1) + 1);
        posicionJ = random.nextInt((matrizPalabras.length - 1) + 1);

        if ( matrizPalabras[posicionI][posicionJ].equals("XXXXX") ) {
            buscaCeldaNoVaciaRecursiva();
        }
        else {
            posicion[0] = posicionI;
            posicion[1] = posicionI;
        }

        return posicion;
    }

    //recibe como parámetro un entero con el número de palabras a repartir
    // y devuelve un vector de cadenas que contendrá tantas palabras como marque
    //el parámetro. Las palabras las tomará de manera aleatoria de matrizPalabras y cada
    //vez que tome una palabra de esa matriz, pondrá en la posición donde estaba esa
    //palabra la cadena “XXXXX”.
    public static String [] repartePalabras(int numeroPalabrasRepartir)
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
}