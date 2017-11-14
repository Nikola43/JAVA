/*
    FUNCIONAMIENTO:
        Vamos a simular el juego de “LA PRIMITIVA”. Le pediremos al usuario 6 números entre el 1 y el 49.
        Una vez el usuario haya escrito sus 6 números, iremos obteniendo números aleatorios entre 1 y 49
        e indicando al usuario el número de aciertos que lleva con cada número aleatorio sacado.
        Ten en cuenta que los seis números aleatorios que se
        obtienen deben ser diferentes (no pueden salir repetidos).

    REQUISITOS:

    RESTRICCIONES:

 */

/*

    ALGORITMO CONVERSOR_DECIMAL_HEXADECIMAL
    VARIABLES:
        CADENA numeroHexadecimal = ""
        CADENA numeroActualCadena
        ENTERO numeroDecimal
        ENTERO numeroActual

    INICIO
        //Le pedimos al usuario que introduzca un numero en base decimal
        ESCRIBIR "Introduce un numero en base decimal: "
        LEER numeroDecimal

        MIENTRAS(numeroDecimal > 0)

            //Extraemos la ultima cifra
            numeroActual = numeroDecimal % 16

            //Segun el valor, ponemos la letra conrrespondiente
            SEGUN(numeroActual)

                PARA(numeroActual == 15)
                    numeroActualCadena = "F"
                PARA(numeroActual == 14)
                    numeroActualCadena = "E"
                PARA(numeroActual == 13)
                    numeroActualCadena = "D"
                PARA(numeroActual == 12)
                    numeroActualCadena = "C"
                PARA(numeroActual == 11)
                    numeroActualCadena = "B"
                PARA(numeroActual == 10)
                    numeroActualCadena = "A"
                DEFECTO
                    numeroActualCadena = numeroActual,""
            FSEGUN

            //Sumamos el valor al numero hexadecimal
            numeroHexadecimal = numeroActualCadena + numeroHexadecimal

            //Eliminamos la ultima cifra
            numeroDecimal = numeroDecimal / 16
        FMIENTRAS
        ESCRIBIR numeroHexadecimal
    FIN

 */
package practicaIIIPSEUDOCODIGOYJAVA;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EJ2
{
    public static void main(String []Args) throws IOException
    {
        String numeroHexadecimal  = "";
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