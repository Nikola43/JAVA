public class Main 
{
    public static void main(String... Args)
    {
	System.out.print("Potencia 2^3 v1: ");
        System.out.println(potencia(2, 3));
        System.out.println();

	    System.out.print("Potencia 2^3 v2: ");
        System.out.println(potencia2(2, 3));
        System.out.println();
    }
    
    /*5. Escribe un algoritmo potencia(Entero base, Entero exp) y su correspondiente programa en java
    que devuelva la base elevada al exponente.*/
    public static int potencia(int base, int exp)
    {
        int val = base;

        if ( exp == 0 )
            return 1;

        if ( exp > 1 )
        {
            val = base * potencia(base, exp - 1);
        }
        return val;
    }

    /*5. Escribe un algoritmo potencia(Entero base, Entero exp) y su correspondiente programa en java
    que devuelva la base elevada al exponente.*/
    public static int potencia2(int base, int exp)
    {
        return (exp == 0) ? 1 : (( exp > 1 ) ? base * potencia2(base, exp - 1) : base);
    }
}
