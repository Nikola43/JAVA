import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class EJ1
{
    public static void main(String []Args) throws IOException
    {
        int mes;
        String dia;
        int numeroDiasMes = 0;
        int contadorDias = 0;

        //Instanciamos un objeto bufferedReader para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Le pedimos al usuario que introduzca el mes
        System.out.print("Introduzca un mes: ");
        mes = Integer.parseInt(bufferedReader.readLine());

        //Le pedimos al usuario que dia empieza el mes
        System.out.print("¿En que dia empieza el mes?: ");
        dia = bufferedReader.readLine();


        switch (mes)
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

        System.out.println("L \t M \t M \t J \t V \t S \t D");
        switch (dia)
        {
            case "lunes"     : System.out.print("");     break;
            case "martes"    : System.out.print("\t ");   break;
            case "miercoles" : System.out.print("\t\t "); break;
            case "jueves"    : System.out.print("\t\t\t "); break;
            case "viernes"   : System.out.print("\t\t\t\t "); break;
            case "sabado"    : System.out.print("\t\t\t\t\t "); break;
            case "domingo"   : System.out.print("\t\t\t\t\t\t "); break;
        }

        while ( contadorDias != numeroDiasMes )
        {
            contadorDias++;
            System.out.print(contadorDias+"\t");
            if ( contadorDias % 7 == 0 )
            {
                System.out.println();
            }
        }
    }
}
