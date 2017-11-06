/*
    2. Diseña un algoritmo y su correspondiente código en java que pida una fecha de nacimiento al usuario (el día
y el año en formato entero y el mes en formato cadena) y diga cuantos años tiene el usuario a día de hoy (21 de
Noviembre del 2014), la fecha del día de hoy debe ir guardada en CONSTANTES, no en variables. La fecha de
nacimiento introducida debe ser válida.
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Main
{
    public static void main(String[] args) throws IOException {
        //Guardamos en constantes la fecha actual
        final int DIA_ACTUAL  = Integer.parseInt(new SimpleDateFormat("dd/MM/yyyy").format(new Date()).split("/")[0]);
        final int MES_ACTUAL  = Integer.parseInt(new SimpleDateFormat("dd/MM/yyyy").format(new Date()).split("/")[1]);
        final int ANIO_ACTUAL = Integer.parseInt(new SimpleDateFormat("dd/MM/yyyy").format(new Date()).split("/")[2]);

        //Variables para almacenar la fecha introducida por el usuario
        int diaIntroducido, mesIntroducido, anioIntroducido;

        //Variables para almacenar la diferencia entre fechas
        int diferenciaDia = 0, diferenciaMes = 0, diferenciaAnio = 0;

        //Variable para saber si la fecha que introdujo el usuario es valida o no
        boolean fechaIntroducidaEsValida;

        //Instanciamos un bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Leemos y validamos fecha
        do
        {
            //Pedimos al usuario que introduzca una su fecha de nacimiento
            //System.out.print("Introduce el dia: "); diaIntroducido  = Integer.parseInt(bufferedReader.readLine());
            //System.out.print("Introduce el mes: "); mesIntroducido  = Integer.parseInt(bufferedReader.readLine());
            //System.out.print("Introduce el año: "); anioIntroducido = Integer.parseInt(bufferedReader.readLine());

            diaIntroducido = 12;
            mesIntroducido = 10;
            anioIntroducido = 2017;

            //Validamos la fecha
            fechaIntroducidaEsValida = validarFecha(diaIntroducido, mesIntroducido, anioIntroducido);

            //Si la fecha es válida
            if (fechaIntroducidaEsValida)
            {

                System.out.println(DIA_ACTUAL+ " "+ MES_ACTUAL + " "+ANIO_ACTUAL);

                System.out.println("Han pasado "+ diferenciaDia +" dias, "+ diferenciaMes + " meses y "+ diferenciaAnio + " años");

            }
            else
            {
                System.out.println("La fecha introducida no es valida, introduzca la fecha de nuevo");
            }
        } while (!fechaIntroducidaEsValida);
    }

    private static boolean validarFecha(int dia, int mes, int anio) {
        boolean esBisiesto;
        boolean fechaValida = false;

        //Primero comprobamos el año
        if ( anio > 0 )
        {
            //Comprobamos si el año es bisiesto o no
            //Si el año es divisible entre 400 o entre 4 y no entre 100, es bisiesto
            esBisiesto = ((anio % 400 == 0) || ((anio % 4 == 0) && (anio % 100 != 0)));

            switch (mes) {
                //Comprobamos el mes de febrero teniendo en cuenta si es bisiesto o no
                case 2:
                    fechaValida = (!esBisiesto && (dia >= 1) && (dia <= 28)) || (esBisiesto && (dia >= 1) && (dia <= 29));
                    break;

                //Comprobamos meses de 31 días
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    fechaValida = ((dia >= 1) && (dia <= 31));
                    break;

                //Comprobamos los meses con 30 días
                case 4:
                case 6:
                case 9:
                case 11:
                    fechaValida = ((dia >= 1) && (dia <= 30));
                    break;
            }
        }
        return fechaValida;
    }
}

