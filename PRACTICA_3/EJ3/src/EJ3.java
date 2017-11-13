import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EJ3
{
    public static void main(String []Args) throws IOException
    {
        String numeroHexadecimal  = " ";
        String numeroActualCadena;

        int numeroDecimal;
        int numeroActual;

        //Instanciamos un objeto bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Le pedimos al usuario que introduzca un numero en base decimal
        System.out.print("Introduce un numero en base decimal: ");
        numeroDecimal = Integer.parseInt(bufferedReader.readLine());

        while(numeroDecimal > 0)
        {
            //Extraemos la ultima cifra
            numeroActual = numeroDecimal % 16;

            //Segun el valor, ponemos la letra conrrespondiente
            switch(numeroActual)
            {
                case 15: numeroActualCadena = "F"; break;
                case 14: numeroActualCadena = "E"; break;
                case 13: numeroActualCadena = "D"; break;
                case 12: numeroActualCadena = "C"; break;
                case 11: numeroActualCadena = "B"; break;
                case 10: numeroActualCadena = "A"; break;
                default: numeroActualCadena = String.valueOf(numeroActual);
            }

            //Sumamos el valor al numero hexadecimal
            numeroHexadecimal = numeroActualCadena + numeroHexadecimal;

            //Eliminamos la ultima cifra
            numeroDecimal = numeroDecimal / 16;
        }
        System.out.println(numeroHexadecimal);
    }
}