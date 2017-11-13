import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EJ4
{
    public static void main(String []Args) throws IOException
    {
        //Instanciamos un objeto bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        int numeroIntroducido;
        int numeroEspacios;

        //Pedimos al usuario que introduzca un numero
        System.out.print("Introduce un numero: ");
        numeroIntroducido = Integer.parseInt(bufferedReader.readLine());

        //Linea horizontal superior
        for(int contadorCaracteres = 0; contadorCaracteres < numeroIntroducido; contadorCaracteres++)
        {
            System.out.print("* ");
        }
        System.out.println();

        //Asignamos el numero introducido al numero de espacios que luego iremos restando
        numeroEspacios = numeroIntroducido;
        //Linea diagonal superior
        for(int contadorCaracteres = 0; contadorCaracteres < numeroIntroducido; contadorCaracteres++)
        {
            for (int contadorEspacios = numeroEspacios; contadorEspacios > 1; contadorEspacios--)
            {
                System.out.print("  ");
            }
            numeroEspacios--;
            System.out.println("*");
        }

        //Linea horizontal medio
        for(int contadorCaracteres = 0; contadorCaracteres < numeroIntroducido; contadorCaracteres++)
        {
            System.out.print("* ");
        }
        System.out.println();

        //Asignamos a 0 al numero de espacios que luego se ira incrementando
        numeroEspacios = 0;
        //Linea diagonal inferior
        for(int contadorCaracteres = 0; contadorCaracteres < numeroIntroducido; contadorCaracteres++)
        {
            for (int contadorEspacios = 0; contadorEspacios < numeroEspacios; contadorEspacios++)
            {
                System.out.print("  ");
            }
            System.out.println("*");
            numeroEspacios++;
        }

        //Linea horizontal inferior
        for(int contadorCaracteres = 0; contadorCaracteres < numeroIntroducido; contadorCaracteres++)
        {
            System.out.print("* ");
        }
        System.out.println();
    }
}
