/*
    FUNCIONAMIENTO:
        Vamos a simular el juego de “LA PRIMITIVA”. Le pediremos al usuario 6 números entre el 1 y el 49.
        Una vez el usuario haya escrito sus 6 números, iremos obteniendo números aleatorios entre 1 y 49
        e indicando al usuario el número de aciertos que lleva con cada número aleatorio sacado.
        Ten en cuenta que los seis números aleatorios que se
        obtienen deben ser diferentes (no pueden salir repetidos).

    REQUISITOS:

        -> Se debe leer por teclado seis numeros que el usuario introduce
        -> Se debe generar seis numeros aleatorios
        -> Se debe comprobar cuantos numeros aleatorios coinciden con los que introdujo el usuario

    RESTRICCIONES:
        -> El numero aleatorio generado debe estar entre 1 y 49
        -> El numero aleagorio generado no puede repetirse
 */

/*

    ALGORITMO PRIMITIVA
    VARIABLES:
        ENTERO numeroIntroducido
        ENTERO num1, num2, num3, num5, num5, num6
        ENTERO numeroAleatorio
        ENTERO contadorNumerosIntroducidos
        ENTERO contadorNumerosAleatoriosGenerados

    CONSTANTES:
        ENTERO MIN_NUMERO_ALEATORIO = 1
        ENTERO MAX_NUMERO_ALEATORIO = 49

    INICIO
        //Leemos seis numeros
        DESDE(contadorNumerosIntroducidos = 1, contadorNumerosIntroducidos < 6, contadorNumerosIntroducidos++)
            ESCRIBIR "Introduce un numero: "
            LEER numeroIntroducido

            //Segun el contador de numeros introducidos guardamos en numero introducido en su variable correspondiente
            SEGUN(contadorNumerosIntroducidos)
                PARA (contadorNumerosIntroducidos == 1 )
                    num1 = numeroIntroducido
                PARA (contadorNumerosIntroducidos == 2 )
                    num2 = numeroIntroducido
                PARA (contadorNumerosIntroducidos == 3 )
                    num3 = numeroIntroducido
                PARA (contadorNumerosIntroducidos == 4 )
                    num4 = numeroIntroducido
                PARA (contadorNumerosIntroducidos == 5 )
                    num5 = numeroIntroducido
                PARA (contadorNumerosIntroducidos == 6 )
                    num6 = numeroIntroducido
            FSEGUN
        FDESDE

        //Generamos seis numeros aleatorios y vamos comprobando los aciertos
        DESDE(contadorNumerosAleatoriosGenerados = 1, contadorNumerosAleatoriosGenerados < 6, contadorNumerosAleatoriosGenerados++)

        FDESDE
    FIN

 */
package practicaIIIPSEUDOCODIGOYJAVA;
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