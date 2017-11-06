/*
1. Diseña un algoritmo y su correspondiente código en java que dados dos números, diga si ambos números
son primos gemelos o no. Dos números son primos gemelos si son primos y solo existe un número entre ellos. El
usuario introducirá siempre primero el menor número y luego el mayor.
 */
public class Main
{
    public static void main(String []Args)
    {
        System.out.println(comprobarNumeroPrimo(8));
    }

    private static boolean comprobarNumeroPrimo(int numero)
    {
        boolean numeroEsPrimo = true;

        for (int i = 2; i < (numero / 2) && numeroEsPrimo; i++)
        {
            if ( numero % i == 0 )
            {
                numeroEsPrimo = false;
            }
        }

        return numeroEsPrimo;
    }
}
