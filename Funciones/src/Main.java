/*
2. Diseñar una función que tenga como parámetros dos números, y que devuelva el máximo.
3. Ídem una versión que calcule el máximo de 3 números y lo devuelva.
4. Función a la que se le pasan dos enteros y muestra todos los números comprendidos entre
ellos,inclusive.
5. Función que devuelve el doble del valor que se le pasa como parámetro.
6. Realizar una función que calcule y devuelva el área o el volumen de un cilindro, según se
especifique. Para distinguir un caso de otro se le pasará el carácter 'a' (para área) o
'v'(para el volumen). Además hemos de pasarle a la función el radio y la altura(que pueden
contener decimales).
7. Realizar una función que dado un número entero devuelva un booleano para indicar si el
número es primo o no.
8. Módulo al que se le pasa un número entero y devuelve el número de divisores primos que
tiene. Usa la función realizada en el ejercicio anterior.
9. Escribir una función que calcule el máximo común divisor de tres números.
10. Escribir una función que calcule el mínimo común múltiplo de tres números.
 */

public class Main
{
    public static void main(String [] Args)
    {
        System.out.println(calcularNumeroDivisoresPrimos(9));
    }
    /*
        10. Escribir una función que calcule el mínimo común múltiplo de tres números.
        CABECERA        -> public static int calcularMinimoComunMultiplo(int n1, n2, n3)
        DESCRIPCION     -> Se le pasa tres números enteros y devuelve el minimo comun multiplo
        ENTRADAS        -> Tres enteros
        PRECONDICIONES  -> -
        SALIDAS         -> Un entero
        POSTCONDICIONES -> Devolvera el minimo comun multiplo
     */

    /*
        9. Escribir una función que calcule el máximo común divisor de tres números.
        CABECERA        -> public static int calcularMaximoComunDivisor(int n1, n2, n3)
        DESCRIPCION     -> Se le pasa tres números enteros y devuelve maximo comun divisor
        ENTRADAS        -> Tres enteros
        PRECONDICIONES  -> -
        SALIDAS         -> Un entero
        POSTCONDICIONES -> Devolvera maximo comun divisor
     */
        public static int mcd (int a, int b)
        {
            if ((a % b) == 0)
                return b;
            else
                return mcd (b, a % b);
        }

    /*
        8. Módulo al que se le pasa un número entero y devuelve el número de divisores primos que
        tiene. Usa la función realizada en el ejercicio anterior.

        CABECERA        -> public static int calcularNumeroDivisoresPrimos(int n)
        DESCRIPCION     -> se le pasa un número entero y devuelve el número de divisores primos que tiene
        ENTRADAS        -> Un entero
        PRECONDICIONES  -> -
        SALIDAS         -> Un entero
        POSTCONDICIONES -> Devolvera el numero de divisores primos
     */
    public static int calcularNumeroDivisoresPrimos(int n)
    {
        int contadorDivisoresPrimos = 0;

        for (int i = 0; i < n; i++)
        {
            if ( numeroEsPrimo(i) && (n % i == 0) )
            {
                contadorDivisoresPrimos++;
            }
        }
        return  contadorDivisoresPrimos;
    }

    /*
        7. Realizar una función que dado un número entero devuelva un booleano para indicar si el
        número es primo o no.

        CABECERA        -> public static boolean numeroEsPrimo(int n)
        DESCRIPCION     -> Comprueba si el numero pasado por parametro es primo o no
        ENTRADAS        -> Un entero
        PRECONDICIONES  -> -
        SALIDAS         -> Un booleano
        POSTCONDICIONES -> Devolvera TRUE cuando sea primo, FALSE cuando no lo sea
    */
    public static boolean numeroEsPrimo(int n) {
        boolean esPrimo = true;

        //Si el numero es 1, 0 o negativo no se considera primo
        if ( n <= 1 )
            esPrimo = false;

        for (int i = 2; i <= (n / 2) && esPrimo; i++) {
            if ( n % i == 0) {
                esPrimo = false;
            }
        }
        return esPrimo;
    }

    /*
    6. Realizar una función que calcule y devuelva el área o el volumen de un cilindro, según se
    especifique. Para distinguir un caso de otro se le pasará el carácter 'a' (para área) o
    'v'(para el volumen). Además hemos de pasarle a la función el radio y la altura(que pueden
    contener decimales).
    /*
        CABECERA        -> public static double calcularAreaVolumen(double radio, double altura, char calcular)
        DESCRIPCION     -> Devolvera el área o el volumen de un cilindro, segun se le pase 'a' o 'v'
                           Tambien se le pasarán el radio y la altura
        ENTRADAS        -> Dos reales y un caracter
        PRECONDICIONES  -> El caracter debe ser 'a' o 'v', el radio y la altura debe ser positivo
        SALIDAS         -> Un double
        POSTCONDICIONES -> Devolvera el area o el volumen segun el caracter introducido
    */
    public static double calcularAreaVolumen(double radio, double altura, char calcular)
    {
        double calculado = 0;

        switch (calcular)
        {
            case 'a' : calculado = 2 * Math.PI * radio * altura; break;          //Area
            case 'v' : calculado = altura * Math.PI * Math.pow(radio, 2); break; //Volumen
        }

        return calculado;
    }

    /*
        5. Función que devuelve el doble del valor que se le pasa como parámetro.
        CABECERA        -> public static int devuelveDoble(int n)
        DESCRIPCION     -> Recibe un numero por parametro y devuelve el doble de ese numero
        ENTRADAS        -> Un entero
        PRECONDICIONES  -> -
        SALIDAS         -> Un entero
        POSTCONDICIONES -> Devolvera el doble del numero pasado por parametro
    */
    public static int devuelveDoble(int n)
    {
        return (n*2);
    }

    /*
        CABECERA        -> public static void imprimir(int n)
        DESCRIPCION     -> Se le pasa un numero y muestra "Modulo ejecutandose" n veces
        ENTRADAS        -> Un entero
        PRECONDICIONES  -> Debe ser positivo y mayor que 0
        SALIDAS         -> -
        POSTCONDICIONES -> -
    */
    public static void imprimir(int n)
    {
        for (int i = 0; i < n; i++) {
            System.out.println((i+1)+" Modulo ejecutandose");
        }
    }

    /*
        2. Diseñar una función que tenga como parámetros dos números, y que devuelva el máximo.
        CABECERA        -> public static int devuelveMaximo(int n1, int n2)
        DESCRIPCION     -> Recibe dos numeros por parametro y devuelve el mayor
        ENTRADAS        -> Dos enteros
        PRECONDICIONES  -> -
        SALIDAS         -> Un entero
        POSTCONDICIONES -> Devolvera el mayor de los dos
     */
    public static int devuelveMaximo(int n1, int n2)
    {
        int mayor;

        if ( n1 > n2)
            mayor = n1;
        else
            mayor = n2;
        return mayor;
    }
}


