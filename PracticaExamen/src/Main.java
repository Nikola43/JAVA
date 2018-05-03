import Clases.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    static final int TIRADA = 15;


    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        ElementoDeJuego[] tipoElemntoJuego = new ElementoDeJuego[4];

        tipoElemntoJuego[0] = new Moneda("mone0");
        tipoElemntoJuego[1] = new MonedaSesgada("moneSesg1", 0.25);
        tipoElemntoJuego[2] = new Dado("dado2");
        tipoElemntoJuego[3] = new DadoSesgado("dado3", 0.1, 0.1, 0.5, 0.1, 0.1, 0.1);

        int opcionMenuPrincipal;
        int contTiradasCara = 0;
        int contTiradaCruz = 0;
        int porcentajeCara = 0;
        int porcentajeCruz = 0;
        int cont1 = 0;
        int cont2 = 0;
        int cont3 = 0;
        int cont4 = 0;
        int cont5 = 0;
        int cont6 = 0;
        int porcentaje1 = 0;
        int porcentaje2 = 0;
        int porcentaje3 = 0;
        int porcentaje4 = 0;
        int porcentaje5 = 0;
        int porcentaje6 = 0;


        do {
            mostrarMenuPrincipal();
            System.out.print("Que desea hacer: ");
            opcionMenuPrincipal = Integer.parseInt(bufferedReader.readLine());

            switch (opcionMenuPrincipal) {
                case 0:
                    System.out.println("\n---------------------");
                    System.out.println("\tMONEDA");
                    System.out.println("---------------------");

                    for (int i = 0; i < TIRADA; i++) {
                        tipoElemntoJuego[opcionMenuPrincipal].tirada();
                        tipoElemntoJuego[opcionMenuPrincipal].mostrarResultadoTirada();

                        if (tipoElemntoJuego[opcionMenuPrincipal].getResultado() == 0) {
                            contTiradasCara++;
                        } else {
                            contTiradaCruz++;
                        }
                    }
                    porcentajeCara = (contTiradasCara * 100) / TIRADA;
                    porcentajeCruz = (contTiradaCruz * 100) / TIRADA;

                    System.out.println("\n*Ha elegido:" + tipoElemntoJuego[opcionMenuPrincipal].toString());
                    System.out.println("*Total tiradas: " + TIRADA);
                    System.out.println("Ha salido un " + porcentajeCara + "% de caras y un " + porcentajeCruz + " % cruz\n");
                    break;

                case 1:
                    System.out.println("\n---------------------");
                    System.out.println("\tMONEDA SESGADA");
                    System.out.println("---------------------");

                    for (int i = 0; i < TIRADA; i++) {
                        tipoElemntoJuego[opcionMenuPrincipal].tirada();
                        tipoElemntoJuego[opcionMenuPrincipal].mostrarResultadoTirada();

                        if (tipoElemntoJuego[opcionMenuPrincipal].getResultado() == 0) {
                            contTiradasCara++;
                        } else {
                            contTiradaCruz++;
                        }
                    }
                    porcentajeCara = (contTiradasCara * 100) / TIRADA;
                    porcentajeCruz = (contTiradaCruz * 100) / TIRADA;

                    System.out.println("\n*Ha elegido:" + tipoElemntoJuego[opcionMenuPrincipal].toString());
                    System.out.println("*Total tiradas: " + TIRADA);
                    System.out.println("Ha salido un " + porcentajeCara + "% de caras y un " + porcentajeCruz + " % cruz\n");
                    break;
                case 2:
                    System.out.println("\n---------------------");
                    System.out.println("\tDADO");
                    System.out.println("---------------------");

                    for (int i = 0; i < TIRADA; i++) {
                        tipoElemntoJuego[opcionMenuPrincipal].tirada();
                        tipoElemntoJuego[opcionMenuPrincipal].mostrarResultadoTirada();

                        switch (tipoElemntoJuego[opcionMenuPrincipal].getResultado())
                        {
                            case 1 : cont1++; break;
                            case 2 : cont2++; break;
                            case 3 : cont3++; break;
                            case 4 : cont4++; break;
                            case 5 : cont5++; break;
                            case 6 : cont6++; break;
                        }
                    }
                    porcentaje1 = (cont1 * 100) / TIRADA;
                    porcentaje2 = (cont2 * 100) / TIRADA;
                    porcentaje3 = (cont3 * 100) / TIRADA;
                    porcentaje4 = (cont4 * 100) / TIRADA;
                    porcentaje5 = (cont5 * 100) / TIRADA;
                    porcentaje6 = (cont6 * 100) / TIRADA;

                    System.out.println("\n*Ha elegido:" + tipoElemntoJuego[opcionMenuPrincipal].toString());
                    System.out.println("*Total tiradas: " + TIRADA);
                    System.out.println("Ha salido "+porcentaje1+" unos");
                    System.out.println("Ha salido "+porcentaje2+" dos");
                    System.out.println("Ha salido "+porcentaje3+" tres");
                    System.out.println("Ha salido "+porcentaje4+" cuatros");
                    System.out.println("Ha salido "+porcentaje5+" cincos");
                    System.out.println("Ha salido "+porcentaje6+" seis");
                    System.out.println();

                    break;
                case 3:
                    System.out.println("\n---------------------");
                    System.out.println("\tDADO SESGADO");
                    System.out.println("---------------------");

                    for (int i = 0; i < TIRADA; i++) {
                        tipoElemntoJuego[opcionMenuPrincipal].tirada();
                        tipoElemntoJuego[opcionMenuPrincipal].mostrarResultadoTirada();

                        switch (tipoElemntoJuego[opcionMenuPrincipal].getResultado())
                        {
                            case 1 : cont1++; break;
                            case 2 : cont2++; break;
                            case 3 : cont3++; break;
                            case 4 : cont4++; break;
                            case 5 : cont5++; break;
                            case 6 : cont6++; break;
                        }
                    }
                    System.out.println("\n*Ha elegido:" + tipoElemntoJuego[opcionMenuPrincipal].toString());
                    System.out.println("PROBABILIDAD 1: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad1());
                    System.out.println("PROBABILIDAD 2: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad2());
                    System.out.println("PROBABILIDAD 3: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad3());
                    System.out.println("PROBABILIDAD 4: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad4());
                    System.out.println("PROBABILIDAD 5: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad5());
                    System.out.println("PROBABILIDAD 6: "+((DadoSesgado)tipoElemntoJuego[opcionMenuPrincipal]).getProbabilidad6());
                    System.out.println("*Total tiradas: " + TIRADA);
                    System.out.println("Ha salido "+porcentaje1+" unos");
                    System.out.println("Ha salido "+porcentaje2+" dos");
                    System.out.println("Ha salido "+porcentaje3+" tres");
                    System.out.println("Ha salido "+porcentaje4+" cuatros");
                    System.out.println("Ha salido "+porcentaje5+" cincos");
                    System.out.println("Ha salido "+porcentaje6+" seis");
                    System.out.println();
                    break;
            }
        } while (4 != opcionMenuPrincipal);
    }


    public static void mostrarMenuPrincipal() {
        System.out.println("Elige un objeto:");
        System.out.println("0. Moneda.");
        System.out.println("1. Moneda Sesgada.");
        System.out.println("2. Dado.");
        System.out.println("3. Dado Sesgado.");
        System.out.println("4. Salir");
    }

}