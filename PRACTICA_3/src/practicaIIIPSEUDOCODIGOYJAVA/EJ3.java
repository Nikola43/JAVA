/*
    FUNCIONAMIENTO:
        Vamos a simular el juego de “LA PRIMITIVA”. Le pediremos al usuario 6 números entre el 1 y el 49.
        Una vez el usuario haya escrito sus 6 números, iremos obteniendo números aleatorios entre 1 y 49
        e indicando al usuario el número de aciertos que lleva con cada número aleatorio sacado.
        Ten en cuenta que los seis números aleatorios que se
        obtienen deben ser diferentes (no pueden salir repetidos).

    REQUISITOS:
        -> Se debe guardar seis numeros enteros que el usuario introduce
        -> Se debe generar seis numeros enteros aleatorios
        -> Se debe comprobar si cada numero aleatorio generado es igual a cualquiera de los que introdujo el usuario

    RESTRICCIONES:
        -> El numero aleatorio generado debe estar entre 1 y 49
        -> El numero aleagorio generado no puede repetirse
 */

package practicaIIIPSEUDOCODIGOYJAVA;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Random;

public class EJ3
{
    public static void main(String []Args) throws IOException {
        int numeroIntroducido;
        int num1 = 0, num2 = 0, num3 = 0, num4 = 0, num5 = 0, num6 = 0;
        int aleatorio1 = 0, aleatorio2 = 0, aleatorio3 = 0, aleatorio4 = 0, aleatorio5 = 0, aleatorio6 = 0;
        int numeroAleatorioGenerado = 0;
        int contadorNumerosIntroducidos;
        int contadorNumerosAleatoriosGenerados;
        int contadorAciertos = 0;

        //Instanciamos un objeto bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        Random random = new Random();

        //Leemos seis numeros
        for(contadorNumerosIntroducidos = 1; contadorNumerosIntroducidos <= 6; contadorNumerosIntroducidos++)
        {
            System.out.print("Introduce un numero: ");
            numeroIntroducido = Integer.parseInt(bufferedReader.readLine());

            //Segun el contador de numeros introducidos guardamos en numero introducido en su variable correspondiente
            switch (contadorNumerosIntroducidos)
            {
                case 1 : num1 = numeroIntroducido; break;
                case 2 : num2 = numeroIntroducido; break;
                case 3 : num3 = numeroIntroducido; break;
                case 4 : num4 = numeroIntroducido; break;
                case 5 : num5 = numeroIntroducido; break;
                case 6 : num6 = numeroIntroducido; break;
            }
        }

        //Generamos seis numeros aleatorios y vamos comprobando los aciertos
        for(contadorNumerosAleatoriosGenerados = 1; contadorNumerosAleatoriosGenerados <= 6; contadorNumerosAleatoriosGenerados++)
        {
            //Se repetira mientras el numero generado sea igual a algun numero aleatorio generado anteriormente
            while ((numeroAleatorioGenerado == aleatorio1) || (numeroAleatorioGenerado == aleatorio2) || (numeroAleatorioGenerado == aleatorio3) ||
                   (numeroAleatorioGenerado == aleatorio4) || (numeroAleatorioGenerado == aleatorio5) || (numeroAleatorioGenerado == aleatorio6) )
            {
                //Generamos un numero aleatorio entre 1 y 49
                numeroAleatorioGenerado = random.nextInt(49 - 1 + 1) + 1;
            }


            if(numeroAleatorioGenerado != aleatorio1 && numeroAleatorioGenerado != aleatorio2 && numeroAleatorioGenerado != aleatorio3 &&
               numeroAleatorioGenerado != aleatorio4 && numeroAleatorioGenerado != aleatorio5 && numeroAleatorioGenerado != aleatorio6)
            {
                switch (contadorNumerosAleatoriosGenerados)
                {
                    case 1 : aleatorio1 = numeroAleatorioGenerado; break;
                    case 2 : aleatorio2 = numeroAleatorioGenerado; break;
                    case 3 : aleatorio3 = numeroAleatorioGenerado; break;
                    case 4 : aleatorio4 = numeroAleatorioGenerado; break;
                    case 5 : aleatorio5 = numeroAleatorioGenerado; break;
                    case 6 : aleatorio6 = numeroAleatorioGenerado; break;
                }
            }

            //Comprobamos si el
            if ((numeroAleatorioGenerado == num1) || (numeroAleatorioGenerado == num2) || (numeroAleatorioGenerado == num3) ||
                (numeroAleatorioGenerado == num4) || (numeroAleatorioGenerado == num5) || (numeroAleatorioGenerado == num6))
            {
                contadorAciertos++;
                System.out.println("Ha acertado!!!");
            }
            else
            {

                System.out.println("No ha acertado");
            }
            System.out.println("Numero de aciertos: "+ contadorAciertos);
        }
    }
}
