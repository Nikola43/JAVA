/*
    AUTOR: Paulo Gustavo Soares Teixeira
    EMAIL: <paulogustavo.soares@iesvelazquez.org>

    FUNCIONAMIENTO:
        Vamos a simular el juego de “LA PRIMITIVA”. Le pediremos al usuario 6 números entre el 1 y el 49.
        Una vez el usuario haya escrito sus 6 números, iremos obteniendo números aleatorios entre 1 y 49
        e indicando al usuario el número de aciertos que lleva con cada número aleatorio sacado.
        Ten en cuenta que los seis números aleatorios que se
        obtienen deben ser diferentes (no pueden salir repetidos).

    REQUISITOS:
        * Se debe guardar los seis numeros que el usuario introduce
        * Se debe generar seis numeros aleatorios
        * Se debe comprobar cuantos numeros aleatorios coinciden con los que introdujo el usuario

    RESTRICCIONES:
        * El numero aleatorio generado debe estar entre 1 y 49
        * El numero aleagorio generado no puede repetirse
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

public class Primitiva
{
    public static void main(String []Args)
    {

    }
}
