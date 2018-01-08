package examen1812;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Random;

public class MasterMind
{
    //fichas secretas
    static char ficha1, ficha2, ficha3, ficha4, ficha5;
    static BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

    //Contador fichas
    static int blancasSecretas, negrasSecretas;

    public static void main(String []Args) throws IOException {
        //fichas jugador
        char fic1, fic2, fic3, fic4, fic5;



        char eleccionUsuario;
        int contadorIntentos = 0;

        //Se asigna valores aleatorios a las variables donde se guardan fichas secretas
        asignaColorAFicha();

        //Se asigna a las bolas blancas y negras cuantas hay de cada color
        blancasSecretas = cuentaColorFichasSecretas('B');
        negrasSecretas  = cuentaColorFichasSecretas('N');

        do
        {
            contadorIntentos++;
            //Pedimos al usuario que introduzca las 5 fichas
            fic1 = pideFicha(1);
            fic2 = pideFicha(2);
            fic3 = pideFicha(3);
            fic4 = pideFicha(4);
            fic5 = pideFicha(5);

            //mostramos combinacion del usuario
            System.out.println("Su combinacion: "+fic1+" "+fic2+" "+fic3+" "+fic4+" "+fic5+" ");
            System.out.println("Tiene "+mensajeFichasBienColocadas(fic1, fic2, fic3, fic4, fic5)+" bien colocadas");

            if ( mensajeFichasBienColocadas(fic1, fic2, fic3, fic4, fic5) < 5)
            {
                System.out.print("¿Quieres que te lo ponga facil? ¿Quieres ver que posiciones has acertado(s/n)?");
                eleccionUsuario = bufferedReader.readLine().charAt(0);

                if (eleccionUsuario == 's')
                {
                    System.out.print("Llevas bien colocadas ");
                    muestraResultadoParcial(fic1, fic2, fic3, fic4, fic5);
                    System.out.println("Hay "+blancasSecretas+ " blancas y "+negrasSecretas+" negras");
                }
            }
            System.out.println();

        }while (!ganador(fic1, fic2, fic3, fic4, fic5));

        System.out.println("Ha ganado con "+contadorIntentos+" intentos");
    }

    public static char pideFicha(int pos) throws IOException {
        char caracterUsuario;

        System.out.print("Introduzca una ficha para la posicion "+pos+": ");
        caracterUsuario = bufferedReader.readLine().charAt(0);

        return caracterUsuario;
    }

    public static char aleatorioBlancoONegro()
    {
        char caracterAleatorio = 0;
        int numeroAleatorio = new Random().nextInt((2 - 1) + 1) + 1;

        switch (numeroAleatorio)
        {
            case 1: caracterAleatorio = 'B'; break;
            case 2: caracterAleatorio = 'N'; break;
        }

        return caracterAleatorio;
    }

    public static void asignaColorAFicha()
    {
        ficha1 = aleatorioBlancoONegro();
        ficha2 = aleatorioBlancoONegro();
        ficha3 = aleatorioBlancoONegro();
        ficha4 = aleatorioBlancoONegro();
        ficha5 = aleatorioBlancoONegro();
    }

    public static int cuentaColorFichasSecretas(char color)
    {
        int contador = 0;

        if (ficha1 == color)
            contador++;

        if (ficha2 == color)
            contador++ ;

        if (ficha3 == color)
            contador++;

        if (ficha4 == color)
            contador++;

        if (ficha5 == color)
            contador++;

        return contador;
    }

    public static boolean comparaFichaEnSuPosicion(char fich, int pos)
    {
        boolean resultadoComprobacion = false;

        switch (pos)
        {
            case 1: resultadoComprobacion = (fich == ficha1); break;
            case 2: resultadoComprobacion = (fich == ficha2); break;
            case 3: resultadoComprobacion = (fich == ficha3); break;
            case 4: resultadoComprobacion = (fich == ficha4); break;
            case 5: resultadoComprobacion = (fich == ficha5); break;
        }

        return resultadoComprobacion;
    }

    public static int mensajeFichasBienColocadas(char f1, char f2, char f3, char f4, char f5)
    {

        int contador = 0;

        if (ficha1 == f1)
            contador++;

        if (ficha2 == f2)
            contador++ ;

        if (ficha3 == f3)
            contador++;

        if (ficha4 == f4)
            contador++;

        if (ficha5 == f5)
            contador++;

        return contador;
    }

    public static boolean ganador(char f1, char f2, char f3, char f4, char f5)
    {
        boolean haGanado = false;

        if ( ficha1 == f1 && ficha2 == f2 && ficha3 == f3 && ficha4 == f4 && ficha5 == f5)
            haGanado = true;

        return haGanado;
    }

    public static char devuelveCaracter(char fich, int pos)
    {
        char caracterDevuelto = 0;

        switch (pos)
        {
            case 1: caracterDevuelto = comparaFichaEnSuPosicion(fich, pos) ? fich : 'X'; break;
            case 2: caracterDevuelto = comparaFichaEnSuPosicion(fich, pos) ? fich : 'X'; break;
            case 3: caracterDevuelto = comparaFichaEnSuPosicion(fich, pos) ? fich : 'X'; break;
            case 4: caracterDevuelto = comparaFichaEnSuPosicion(fich, pos) ? fich : 'X'; break;
            case 5: caracterDevuelto = comparaFichaEnSuPosicion(fich, pos) ? fich : 'X'; break;
        }

        return caracterDevuelto;
    }

    public static void muestraResultadoParcial(char f1, char f2, char f3, char f4, char f5)
    {
        char faux1 = devuelveCaracter(f1, 1);
        char faux2 = devuelveCaracter(f2, 2);
        char faux3 = devuelveCaracter(f3, 3);
        char faux4 = devuelveCaracter(f4, 4);
        char faux5 = devuelveCaracter(f5, 5);

        System.out.println(faux1+" "+faux2+" "+faux3+" "+faux4+" "+faux5);
    }
}
