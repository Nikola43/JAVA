import org.jetbrains.annotations.Contract;

public class Main {

    public static int m1[][] = {
            {1,0,0,0},
            {0,0,0,0},
            {0,0,3,0},
            {0,0,0,0}};

    public static int m2[][] = {
            {1,0,0,0},
            {0,0,0,0},
            {0,0,4,0},
            {0,0,0,0}};

    public static void main(String... args)
    {
        int [][]m3 = sumaMatrices(m1, m2);
        imprimirMatriz(m3);
    }

    public static void imprimirMatriz(int [][]m)
    {
        for (int i = 0; i < m.length; i++)
        {
            for (int j = 0; j < m[i].length; j++)
            {
                System.out.print(m[i][j]+" ");
            }
            System.out.println();
        }

    }

    /* 5. Crea una función esMatrizIdentidad que se le pase como parámetro una matriz y
    devuelva cierto si la matriz es Identidad o falso si no lo es. Una matriz es identidad si es
    cuadrada, todos los elementos de la diagonal son 1 y el resto de elementos son 0.*/
    public static boolean esMatrizIdentidad(int m[][])
    {

        return false;
    }
    /*6. Crea una función esMatrizTriangular que se le pase como parámetro una matriz y
    devuelva una cadena “es diagonal” si todos los elementos excepto la diagonal son 0 ́s,
    “es triangular superior” si todos los elementos por encima de la diagonal son 0’s, “es
    triangular inferior” si todos los elementos por debajo de la diagonal son 0’s o “no es
    triangular” si no cumple con ninguna de las anteriores. Utiliza dos funciones auxiliares
    esMatrizTriangularSuperior y esMatrizTriangularInferior que devuelvan verdadero o
    falso.*/

    public static boolean esMatrizTriangularSuperior(int m[][])
    {
       boolean triangularSuperior = false;
       return triangularSuperior;
    }

    public static boolean esMatrizTriangularInferior(int m[][])
    {
        boolean triangularInferior = false;
        return triangularInferior;
    }

    /*7. Crea una función sumaMatrices que se le pase como parámetro dos matrices tipo
    double y devuelva otra matriz con la suma de las dos anteriores (ten en cuenta que las
    dos matrices deben tener el mismo número de filas y de columnas), en caso de no
    poder hacerlo devolverá la matriz nula*/
    public static int[][] sumaMatrices(int [][]a, int [][]b)
    {
        int [][]m = new int [a.length][a.length];

        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < a.length; j++) {
                m[i][j] = a[i][j] + b[i][j];
            }
        }
        return m;
    }

    /*8. Crea una función multiplicaMatrices que se le pase como parámetro dos matrices
    tipo doublé y devuelva otra matriz con la multiplicación de las dos anteriores (ten en
    cuenta que para poder multiplicar dos matrices el número de filas de la primera matriz
    debe ser igual al número de columnas de la segunda matriz) .
    */

}
