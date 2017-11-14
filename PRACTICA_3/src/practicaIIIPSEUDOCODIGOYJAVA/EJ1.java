/*
    FUNCIONAMIENTO:
        Diseña un algortimo que pida al usuario un mes (en formato numérico y sin tener en cuenta los años bisiestos)
        y el día en que empieza el mes en formato cadena (lunes, martes, miércoles, jueves, viernes, sábado o domingo)
        e imprima por pantalla el calendario de dicho mes.

    REQUISITOS:
        -> Se debe leer por teclado el dia en formato numerico
        -> Se debe leer por teclado el mes en formato cadena
        -> El calendario debe empezar dia de la semana que introdujo el usuario
        -> El mes debe tener el numero de dias correspondiente a su posicion en el año (28, 30 o 31)

    RESTRICCIONES:
        -> El el numero del mes debe ser entre 1 y 12
        -> El dia debe ser lunes, martes, miercoles, jueves, viernes, sabado o domingo

    SUPOSICIONES
        -> Suponemos que el usuario es buena gente e introduce los datos bien :)
 */

/*
    ALGORITMO
    VARIABLES:
        CADENA diaIntroducido
        ENTERO mesIntroducido, numeroDiasMes = 0, contadorDiasMes = 0, numeroDiasFinalSemana = 0, diaActualSemana

    CONSTANTES:

    INICIO
        //Le pedimos al usuario que introduzca el mes
        ESCRIBIR "Introduzca un mes: "
        LEER mesIntroducido

        //Le pedimos al usuario que dia de la semana empieza el mes
        ESCRIBIR "¿En que dia empieza el mes?: "
        LEER diaIntroducido

        //Segun el mes, tendra 28, 30 o 31 dias
        SEGUN (mesIntroducido)

            //febrero
            PARA (mesIntroducido == 2)
                numeroDiasMes = 28

            //Meses con 31 dias
            PARA (mesIntroducido == 1)
            PARA (mesIntroducido == 3)
            PARA (mesIntroducido == 5)
            PARA (mesIntroducido == 7)
            PARA (mesIntroducido == 8)
            PARA (mesIntroducido == 10)
            PARA (mesIntroducido == 12)
                numeroDiasMes = 31

            //Meses con 30 dias
            PARA (mesIntroducido == 4)
            PARA (mesIntroducido == 6)
            PARA (mesIntroducido == 9)
            PARA (mesIntroducido == 11)
                numeroDiasMes = 30
        FSEGUN

        //Mostramos la cabecera del calendario
        ESCRIBIR "L\tM\tX\tJ\tV\tS\tD"

        //Segun el dia de la semana, imprimimos los tabuladores equivalentes
        //y calculamos cuantos dias faltan para terminar la primera semana del mes
        SEGUN (diaIntroducido)
            PARA (diaIntroducido == "lunes")
                numeroDiasFinalSemana = 7

            PARA (diaIntroducido == "martes")
                numeroDiasFinalSemana = 6
                ESCRIBIR "\t"

            PARA (diaIntroducido == "miercoles")
                numeroDiasFinalSemana = 5
                ESCRIBIR "\t\t"

            PARA (diaIntroducido == "jueves")
                numeroDiasFinalSemana = 4
                ESCRIBIR "\t\t\t"

            PARA (diaIntroducido == "viernes")
                numeroDiasFinalSemana = 3
                ESCRIBIR "\t\t\t\t"

            PARA (diaIntroducido == "sabado")
                numeroDiasFinalSemana = 2
                ESCRIBIR "\t\t\t\t\t"

            PARA (diaIntroducido == "domingo")
                numeroDiasFinalSemana = 1
                ESCRIBIR "\t\t\t\t\t\t"
        FSEGUN

        //Calculamos el dia de la semana que empieza el mes
        //Restandole a 7 el dias que falta para que acabe la semana
        diaActualSemana = 7 - numeroDiasFinalSemana

        //Mientras no lleguemos a final de mes
        MIENTRAS ( contadorDiasMes != numeroDiasMes )

            contadorDiasMes++
            diaActualSemana++

            //Mostramos el dia
            ESCRIBIR contadorDiasMes+"\t"

            //Si lleguamos a domingo hacemos salto de linea y reseteamos el contador de dias de la semana
            SI ( diaActualSemana == 7 )
                ESCRIBIR "\n"
                diaActualSemana = 0
            FSI
        FMIENTRAS
    FIN
 */

package practicaIIIPSEUDOCODIGOYJAVA;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EJ1
{
    public static void main(String []Args) throws IOException
    {
        //Variables para manejar los meses y los dias
        String diaIntroducido;
        int mesIntroducido, numeroDiasMes = 0, contadorDiasMes = 0, numeroDiasFinalSemana = 0, diaActualSemana;

        //Instanciamos un objeto bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Le pedimos al usuario que introduzca el mes
        System.out.print("Introduzca un mes: ");
        mesIntroducido = Integer.parseInt(bufferedReader.readLine());

        //Le pedimos al usuario que dia de la semana empieza el mes
        System.out.print("¿En que dia empieza el mes?: ");
        diaIntroducido = bufferedReader.readLine();

        //Segun el mes, tendra 28, 30 o 31 dias
        switch (mesIntroducido)
        {
            //febrero
            case 2:
                numeroDiasMes = 28; break;

            //Meses con 31 dias
            case 1 :
            case 3 :
            case 5 :
            case 7 :
            case 8 :
            case 10 :
            case 12 :
                numeroDiasMes = 31; break;

            //Meses con 30 dias
            case 4 :
            case 6 :
            case 9 :
            case 11 :
                numeroDiasMes = 30; break;
        }

        //Mostramos la cabecera del calendario
        System.out.println("L\tM\tX\tJ\tV\tS\tD");

        //Segun el dia de la semana, imprimimos los tabuladores equivalentes
        //y calculamos cuantos dias faltan para terminar la semana
        switch (diaIntroducido)
        {
            case "lunes"     : numeroDiasFinalSemana = 7; break;
            case "martes"    : numeroDiasFinalSemana = 6; System.out.print("\t");   break;
            case "miercoles" : numeroDiasFinalSemana = 5; System.out.print("\t\t"); break;
            case "jueves"    : numeroDiasFinalSemana = 4; System.out.print("\t\t\t"); break;
            case "viernes"   : numeroDiasFinalSemana = 3; System.out.print("\t\t\t\t"); break;
            case "sabado"    : numeroDiasFinalSemana = 2; System.out.print("\t\t\t\t\t"); break;
            case "domingo"   : numeroDiasFinalSemana = 1; System.out.print("\t\t\t\t\t\t"); break;
        }

        //Calculamos el dia de la semana que empieza el mes
        //Restandole a 7 el dias que falta para que acabe la semana
        diaActualSemana = 7 - numeroDiasFinalSemana;

        //Mientras no lleguemos a final de mes
        while ( contadorDiasMes != numeroDiasMes )
        {
            contadorDiasMes++;
            diaActualSemana++;

            //Mostramos el dia
            System.out.print(contadorDiasMes+"\t");

            //Si lleguamos a domingo hacemos salto de linea y reseteamos el contador de dias de la semana
            if ( diaActualSemana == 7 )
            {
                System.out.println();
                diaActualSemana = 0;
            }
        }
    }
}
