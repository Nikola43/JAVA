import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Main
{
    public static void main(String []Args)
    {

    }

    public static boolean esBisiesto(int anyo)
    {
        boolean esBisiesto = false;

        if ((anyo % 4 == 0) && ((anyo % 100 != 0) || (anyo % 400 == 0)))
            esBisiesto = true;

        return esBisiesto;
    }

    public static int diasMes(int mes, int anyo)
    {
        int numeroDias = 0;

        switch (mes)
        {
            //Febrero
            case 2 : numeroDias = esBisiesto(anyo) ? 29 : 28; break;

            //Meses 31 dias
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: numeroDias = 31; break;

            //Meses 30 dias
            case 4:
            case 6:
            case 9:
            case 11: numeroDias = 31; break;
        }
        return numeroDias;
    }

    public static int pasaMesAEntero(String mesCad)
    {
        int mes;

        switch (mesCad)
        {
            case "enero"      : mes = 1;  break;
            case "febrero"    : mes = 2;  break;
            case "marzo"      : mes = 3;  break;
            case "abril"      : mes = 4;  break;
            case "mayo"       : mes = 5;  break;
            case "junio"      : mes = 6;  break;
            case "julio"      : mes = 7;  break;
            case "agosto"     : mes = 8;  break;
            case "septiembre" : mes = 9;  break;
            case "octubre"    : mes = 10; break;
            case "noviembre"  : mes = 11; break;
            case "diciembre"  : mes = 12; break;
            default           : mes = -1;
        }

        return mes;
    }
    public static boolean fechaCorrecta(int dia, int mes, int anyo)
    {
        boolean fechaValida = false;
        boolean bisiesto = false;

        //Comprobamos si el año es bisiesto o no
        //Si el año es divisible entre 400 o entre 4 y no entre 100, es bisiesto
        bisiesto = esBisiesto(anyo);

        switch (mes)
        {
            //Comprobamos el mes de febrero teniendo en cuenta si es bisiesto o no
            case 2 :
            if( !bisiesto && dia >= 1 && dia <= 28 )
                fechaValida = true;
            else if (bisiesto && dia >= 1 && dia <= 29 )
                fechaValida = true;

            //Meses 31 dias
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: if ( dia >= 1 && dia <= 31) fechaValida = true; break;

            //Meses 30 dias
            case 4:
            case 6:
            case 9:
            case 11: if ( dia >= 1 && dia <= 30) fechaValida = true; break;
        }

        return fechaValida;
    }

    public static void calculaEdad(int dia, int mes, int anyo)
    {
        int diaActual, mesActual, anyoActual;


    }

    public static
    getFechaActual()
    {
        try
        {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            String currentDateTime = dateFormat.format(new Date());
            System.out.println(currentDateTime);


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

/*
Boolean esMayor(Entero dia1, Entero mes1)
//devuelve cierto si la fecha (dia1,mes1,anyo1) es mayor que la fecha (dia2,mes2,anyo2).
calculaEdad(Entero dia, Entero mes, Entero anyo) // que muestra por pantalla la edad de la fecha
// dada
 */
