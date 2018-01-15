public class Main {
    public static void main(String... Args)
    {
        //1
        imprimeNumerosAscendente(5);
        System.out.println();

        //2
        imprimeNumerosDescendente(5);
        System.out.println();

        //3
        imprimeImparesNoPrimos(10);
        System.out.println();

        //4
        tablaDeMultiplicar(5,10);
        System.out.println();

        //5
        System.out.println(potencia(2, 2));
        System.out.println();

        //6
        cifrasNumero(13433);

        //8
        System.out.println(f(101));

        //9
       // sumaNumeros(5);

        /*10. Escribe un algortimo dividirNumeros(Entero a, Entero b) y su correspondiente código en java
        que devuelva el resultado de dividir a entre b.*/
        dividirNumeros(3, 6);

    }

    private static int dividirNumeros(int a, int b)
    {
        return 3;
    }

    /*1. Escribe un algoritmo imprimeNumerosAscendente(Entero n) y su correspondiente código en java
    que a partir del número n pasado como parámetro imprima todos los números desde 1 a n.*/
    public static void imprimeNumerosAscendente(int n)
    {
        if (n > 0) {
            imprimeNumerosAscendente(n - 1);
            System.out.println(n);
        }
    }

    /*2. Idem del ejercicio anterior pero que imprima todos los números de n a 1 y se llame
    imprimeNumerosDescendente(Entero n).*/
    public static void imprimeNumerosDescendente(int n)
    {
        if (n > 0)
        {
            System.out.println(n);
            imprimeNumerosDescendente(n - 1);
        }
    }
    /*3. Escribe un algoritmo imprimeImparesNoPrimos(Entero n) y su correspondiente código en java
    que imprima sólo los números impares y no primos desde 1 hasta n.*/
    public static void imprimeImparesNoPrimos(int n)
    {
        if (n > 0)
        {
            imprimeImparesNoPrimos(n - 1);
            if ( !esPar(n) && !esPrimo(n))
            {
                System.out.println(n);
            }
        }
    }

    /*
    4. Escribe un algoritmo tablaDeMultiplicar(Entero num) y su correspondiente código en java que
    imprima la tabla de multiplicar del número num.
    */
    public static void tablaDeMultiplicar(int n, int n2)
    {
        if (n2 > 0)
        {
            tablaDeMultiplicar(n,n2 - 1);
            System.out.println(n + " * " + n2 + " = "+ n*n2);
        }
    }
    /*5. Escribe un algoritmo potencia(Entero base, Entero exp) y su correspondiente programa en java
    que devuelva la base elevada al exponente.*/
    public static int potencia(int base, int exp)
    {
        return (exp == 0) ? 1 : (( exp > 1 ) ? base * potencia(base,exp - 1) : 1  );
    }

    /*6. Escribe un algoritmo recursivo cifrasNumero(num) que saque las cifras de un número entero en
    su mismo orden, por ejemplo, para el número 1051 la salida debe ser 1,0,5,1.*/
    public static void cifrasNumero(int n)
    {
        int numeroDigitos = (int)(Math.log10(n)+1);
        int digitoActual;


    }

    /*8. ¿Cual es el resultado de esta función para distintos valores de x?*/
    public static int f(int x)
    {
        if ( x > 100 )
            return (x - 10);
        else
            return (f(f(x+11)));
    }


    /*9. Escribe un algoritmo sumaNumeros(Entero n) y su correspondiente código en java que devuelva
    la suma de todos los números desde 1 hasta n.*/
    public static int sumaNumeros(int n)
    {
        int acumulador;
        int aux = 0;

        if (n > 0) {
            acumulador = n;
            aux = acumulador +  sumaNumeros(n - 1);
            System.out.println(aux);
        }
        return aux;
    }




    public static boolean esPar(int numero) {
       return (numero % 2 == 0);
    }

    public static boolean esPrimo(int number) {
        int sqrt = (int) Math.sqrt(number) + 1;
        for (int i = 2; i < sqrt; i++)
        {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }

    public static int factorialRecursivo2(int numero) {
        return ((numero == 0) ? 1 : numero * factorialRecursivo2(numero - 1));
    }
}