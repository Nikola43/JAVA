public class Main {

    public static void main(String... args)
    {
          double[][] m1 = {
                {1,0,0,0},
                {1,1,0,0},
                {2,0,1,0},
                {3,0,0,1}};

          double m2[][] = {
                {2,0,0,0},
                {0,2,0,0},
                {0,0,2,0},
                {0,0,0,2}};

        //1
        System.out.println("Suma de todos los elementos de la matriz: "+sumaMatriz(m2));

        //2
        buscaElemento(m2,1);

        //3
        System.out.println("Es cuadrada? "+esMatrizCuadrada(m1));

        //4
        System.out.println("Es escalar? "+esMatrizEscalar(m1));

        //5
        System.out.println("Es identidad? "+esMatrizIdentidad(m1));

        //7
        imprimirMatriz(sumaMatrices(m1, m2));

        //8
        imprimirMatriz(multiplicaMatrices(m1, m2));
    }

    /*1. Crea una función sumaMatriz a la que se le pase como parámetro una matriz de tipo
    entero y devuelva la suma de todos los elementos de dicha matriz.*/
    private static double sumaMatriz(double [][]matriz)
    {
        int suma = 0;
        /*
        for (int i = 0; i < matriz.length; i++)
            for (int j = 0; j < matriz[i].length; j++)
                suma += matriz[i][j];
        }*/
        for (double[] filaActual: matriz)
            for (double elementoActual: filaActual)
                suma += elementoActual;

        return suma;
    }

    /*2. Crea una función buscaElemento que se le pase como parámetro una matriz de tipo
    entero y un número entero y muestre por pantalla todas las apariciones de ese
    número y en qué fila y columna se encuentra dicho número. Al final también debe
    imprimir el número de apariciones de dicho número.*/
    private static void buscaElemento(double [][]matriz, double numeroBuscado)
    {
        int counter = 0;

        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                if (matriz[i][j] == numeroBuscado) {
                    System.out.println("Numero encontrado: " + matriz[i][j]);
                    System.out.println("Fila:" + i);
                    System.out.println("Columna:" + j);
                    counter++;
                }
            }
        }
        System.out.println("El numero ha aparecido "+counter+" veces");
    }

    /*3. Crea una función esMatrizCuadrada que se le pase como parámetro una matriz y
        devuelva cierto si la matriz es cuadrada o falso si no lo es. Una matriz es cuadrada
        cuando el número de filas es igual al número de columnas. */
    private static boolean esMatrizCuadrada(double[][] matriz)
    {
        boolean esCuadrada = true;
        int numeroFilas = matriz.length;

        for (int i = 0; i < numeroFilas && matriz[i].length == numeroFilas; i++)
            for (int j = 0; j < matriz[i].length; j++)
                if (matriz[i].length != numeroFilas)
                    esCuadrada = false;

        return esCuadrada;
    }

    /*4. Crea una función esMatrizEscalar que se le pase como parámetro una matriz y
    devuelva cierto si la matriz es Escalar o falso si no lo es. Una matriz es escalar si es
    cuadrada y si todos los elementos de la diagonal son iguales.*/
    private static boolean esMatrizEscalar(double[][] matriz)
    {
        boolean esEscalar = true;
        double ultimoElemento;
        double elementoActual;

        if (esMatrizCuadrada(matriz))
        {
            for (int i = 1; i < matriz.length; i++)
            {
                ultimoElemento = matriz[i - 1][i - 1];
                elementoActual = matriz[i][i];

                if (elementoActual != ultimoElemento)
                    esEscalar = false;
            }
        }
        else
            esEscalar = false;

        return esEscalar;
    }

    /* 5. Crea una función esMatrizIdentidad que se le pase como parámetro una matriz y
    devuelva cierto si la matriz es Identidad o falso si no lo es. Una matriz es identidad si es
    cuadrada, todos los elementos de la diagonal son 1 y el resto de elementos son 0.*/
    private static boolean esMatrizIdentidad(double[][] matriz)
    {
        boolean esIdentitad = true;

        if(esMatrizCuadrada(matriz) && esMatrizEscalar(matriz))
        {
            for (int i = 0; i < matriz.length && esIdentitad; i++)
            {
                for (int j = 0; j < matriz[i].length; j++)
                {
                    if ( (matriz[i][i] != 1) || ((matriz[i][i] != matriz[i][j]) && (matriz[i][j] != 0)) )
                        esIdentitad = false;
                }
            }
        }
        else
            esIdentitad = false;

        return esIdentitad;
    }
    /*6. Crea una función esMatrizTriangular que se le pase como parámetro una matriz y
    devuelva una cadena “es diagonal” si todos los elementos excepto la diagonal son 0 ́s,
    “es triangular superior” si todos los elementos por encima de la diagonal son 0’s, “es
    triangular inferior” si todos los elementos por debajo de la diagonal son 0’s o “no es
    triangular” si no cumple con ninguna de las anteriores. Utiliza dos funciones auxiliares
    esMatrizTriangularSuperior y esMatrizTriangularInferior que devuelvan verdadero o
    falso.*/
    private static boolean esMatrizTriangularSuperior(int m[][])
    {
       boolean triangularSuperior = false;
       return false;
    }

    private static boolean esMatrizTriangularInferior(int m[][])
    {
        boolean triangularInferior = false;
        return false;
    }

    /*7. Crea una función sumaMatrices que se le pase como parámetro dos matrices tipo
    double y devuelva otra matriz con la suma de las dos anteriores (ten en cuenta que las
    dos matrices deben tener el mismo número de filas y de columnas), en caso de no
    poder hacerlo devolverá la matriz nula*/
    private static double[][] sumaMatrices(double [][]a, double [][]b)
    {
        double [][]m = new double [a.length][a.length];

        for (int i = 0; i < a.length; i++)
            for (int j = 0; j < a.length; j++)
                m[i][j] = a[i][j] + b[i][j];

        return m;
    }
    /*8. Crea una función multiplicaMatrices que se le pase como parámetro dos matrices
    tipo doublé y devuelva otra matriz con la multiplicación de las dos anteriores (ten en
    cuenta que para poder multiplicar dos matrices el número de filas de la primera matriz
    debe ser igual al número de columnas de la segunda matriz) .*/
    private static double[][] multiplicaMatrices (double[][] m1, double[][] m2) {
        int longitudFilasM1 = m1.length;
        int longitudColumnasM1 = m1[0].length;

        int longitudFilasM2 = m2.length;
        int longitudColumnasM2 = m2[0].length;

        double[][] multiplicacion = null;

        if (longitudColumnasM1 == longitudFilasM2)
        {
            // La nueva matriz es de filas de M1 y columnas de M2
            multiplicacion = new double[longitudFilasM1][longitudColumnasM2];

            for (int i = 0; i < multiplicacion.length; i++) {
                for (int j = 0; j < multiplicacion[i].length; j++) {
                    for (int k = 0; k < longitudFilasM2; k++) {
                        // El nuevo bucle suma la multiplicacion de la fila por la columna
                        multiplicacion [i][j] += m1[i][k] * m2[k][j];
                    }
                }
            }
        }

        return multiplicacion;
    }

    private static void imprimirMatriz(double[][] matriz)
    {
        for (double[] filaActual: matriz) {
            for (double elementoActual : filaActual)
            {
                System.out.print(elementoActual+" ");
            }
            System.out.println();
        }
    }
}
