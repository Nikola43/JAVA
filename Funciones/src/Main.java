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
        imprimir(4);

        //System.out.println(numeroEsPrimo(3));
        //System.out.println(numeroEsPrimo(4));

        System.out.println(numeroEsPrimo(2));
        System.out.println(numeroEsPrimo(4));

        System.out.println(numeroEsPrimo(0));
        System.out.println(numeroEsPrimo(1));
        System.out.println(numeroEsPrimo(2));
    }

    /*
    CABECERA        -> public static void imprimir(int n)
    DESCRIPCION     -> Se le pasa un numero y muestra "Modulo ejecutandose" n veces
    ENTRADAS        -> Un entero
    PRECONDICIONES  -> Debe ser positivo y mayor que 0
    SALIDAS         -> -
    POSTCONDICIONES -> -
    */
    private static void imprimir(int n)
    {
        for (int i = 0; i < n; i++) {
            System.out.println((i+1)+" Modulo ejecutandose");
        }
    }

    /*
    CABECERA        -> private static boolean numeroEsPrimo(int n)
    DESCRIPCION     -> Comprueba si el numero pasado por parametro es primo o no
    ENTRADAS        -> Un entero
    PRECONDICIONES  -> -
    SALIDAS         -> Un booleano
    POSTCONDICIONES -> Devolvera TRUE cuando sea primo, FALSE cuando no lo sea
    */
    private static boolean numeroEsPrimo(int n) {
        boolean esPrimo = true;

        if ( n <= 1 )
            esPrimo = false;

        for (int i = 2; i <= (n / 2) && esPrimo; i++) {
            if ( n % i == 0) {
                esPrimo = false;
            }
        }
        return esPrimo;
    }
}


