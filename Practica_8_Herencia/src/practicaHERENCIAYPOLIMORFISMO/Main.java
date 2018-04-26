package practicaHERENCIAYPOLIMORFISMO;

import practicaHERENCIAYPOLIMORFISMO.Clases.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

    private final static int FRONTERA_X = 10;
    private final static int FRONTERA_Y = 10;

    public static void main(String[] args) throws IOException {

        char opcionMenuPrincipal;
        int robotElegido;
        char opcionMenuObjetos;
        int numeroPasos;
        int direccionRobot;

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Un vector de 3 posiciones que pueda contener Robots
        Robot[] robots = new Robot[3];

        //Un vector de 5 posiciones que pueda contener tipos Objeto
        Objeto[] objetos = new Objeto[5];

        //matriz que usaremos para mostrar las situaciones de los robots y objetos
        String[][] superficie = new String[FRONTERA_X][FRONTERA_Y];

        robots[0] = new RobotCogedor(0, 1, 3);
        robots[1] = new RobotDisparador(9, 9, 2, 'n');
        robots[2] = new RobotCogedor(4, 5, 4);

        objetos[0] = new Pelota(3, 3, (float) 2.5, (float) 1.4);
        objetos[1] = new PoligonoPlano(9, 0, (float) 1.3, (float) 2.4, (float) 4.5);
        objetos[2] = new PoligonoPlano(1, 5, (float) 2.15, (float) 2, (float) 1);
        objetos[3] = new PoligonoPlano(0, 9, (float) 2, (float) 4.5, (float) 3.1);
        objetos[4] = new Pelota(4, 9, (float) 3.1, (float) 4);

        do {
            //Ajustamos tablero y lo mostramos
            ajustarTablero(superficie, robots, objetos);
            mostrarMatriz(superficie);

            do {
                System.out.print("Elige el robot que quieres usar (0-" + robots.length + "): ");
                robotElegido = Integer.parseInt(bufferedReader.readLine());

                if (robotElegido < 0 || robotElegido > robots.length)
                    System.out.println("Opcion no valida!\n");

            } while (robotElegido < 0 || robotElegido > robots.length);



                //Mostramos menu al usuario
                do {
                    mostrarMenuPrincipal();
                    System.out.print("¿Que desea hacer?: ");
                    opcionMenuPrincipal = Character.toLowerCase(bufferedReader.readLine().charAt(0));

                    if (opcionMenuPrincipal < 'a' || opcionMenuPrincipal > 'd')
                        System.out.println("Opcion no valida!\n");

                } while (opcionMenuPrincipal < 'a' || opcionMenuPrincipal > 'd');


                switch (opcionMenuPrincipal) {
                    //MOSTRAR ROBOT
                    case 'a':
                        mostrarDatosRobot(robotElegido, robots);
                        break;

                    //MOSTRAR OBJETOS DEL ROBOT (0.5 puntos)
                    case 'b':

                        if (robots[robotElegido] instanceof RobotCogedor) {
                            do {
                                mostrarMenuObjetosRobot();
                                System.out.print("Como quiere ordenar los objetos?: ");
                                opcionMenuObjetos = (Character.toLowerCase(bufferedReader.readLine().charAt(0)));

                                if (opcionMenuObjetos != 'a' && opcionMenuObjetos != 'p' && opcionMenuObjetos != 'v')
                                    System.out.println("Opcion no valida!\n");

                            } while (opcionMenuObjetos != 'a' && opcionMenuObjetos != 'p' && opcionMenuObjetos != 'v');

                            //Mostrar objetos del robot
                            switch (opcionMenuObjetos) {
                                case 'a':
                                case 'v':
                                    ((RobotCogedor) robots[robotElegido]).ordenarObjetosCogidosPorAreaYVolumen();
                                    break;
                                case 'p':
                                    ((RobotCogedor) robots[robotElegido]).ordenarObjetosCogidosPorPeso();
                                    break;
                            }
                            //Mostramos los objetos
                            ((RobotCogedor) robots[robotElegido]).mostrarObjetosCogidos();
                        } else
                            System.out.println("No es un robot cogedor");
                        break;

                    //MOVER ROBOT
                    case 'c':
                        //Preguntamos cuantos pasos quiere dar el robot
                        do {
                            System.out.print("Indique cuantos pasos dara el robot(1-" + (FRONTERA_X - 1) + "): ");
                            numeroPasos = Integer.parseInt(bufferedReader.readLine());
                            if (numeroPasos < 1 || numeroPasos > FRONTERA_X - 1)
                                System.out.println("Opcion no validaa!\n");

                        } while (numeroPasos < 1 || numeroPasos > FRONTERA_X - 1);

                        //Preguntamos la direccion
                        do {
                            mostrarMenuMovimientoRobot();
                            System.out.print("Indique hacia donde se movera el robot: ");
                            direccionRobot = Integer.parseInt(bufferedReader.readLine());

                            if (direccionRobot < 1 || direccionRobot > 4)
                                System.out.println("Opcion no valida!\n");
                        } while (direccionRobot < 1 || direccionRobot > 4);

                        switch (direccionRobot){

                            //Retroceder Y
                            case 1 :
                                if (!robots[robotElegido].retrocederEjeY(numeroPasos, 0)
                                        && superficie[robots[robotElegido].getPosY() - numeroPasos][robots[robotElegido].getPosX()].compareTo("*") < 0)
                                    System.out.println("Posicion no valida!");
                                break;

                            //Avanzar Y
                            case 2 :
                                if (!robots[robotElegido].avanzarEjeY(numeroPasos, FRONTERA_Y)
                                        && superficie[robots[robotElegido].getPosY() + numeroPasos][robots[robotElegido].getPosX()].compareTo("*") < 0)
                                    System.out.println("Posicion no valida!");
                                break;

                            //Retroceder Y
                            case 3 :
                                if (!robots[robotElegido].retrocederEjeX(numeroPasos, 0)
                                        && superficie[robots[robotElegido].getPosX() - numeroPasos][robots[robotElegido].getPosX()].compareTo("*") < 0)
                                    System.out.println("Posicion no valida!");
                                break;

                            //Avanzar Y
                            case 4 :
                                if (!robots[robotElegido].avanzarEjeX(numeroPasos, FRONTERA_X)
                                        && superficie[robots[robotElegido].getPosX() + numeroPasos][robots[robotElegido].getPosX()].compareTo("*") < 0)
                                    System.out.println("Posicion no valida!");
                                break;
                        }
                        break;


                    //COGER OBJETO CON ROBOT COGEDOR
                    case 'd' :

                        break;

                    //COGER OBJETO CON ROBOT COGEDOR
                    case 'e' :

                        break;
                }
        } while (opcionMenuPrincipal != 'd');

    }
    private static void ajustarTablero(String[][] superficie, Robot[] robotsEnTablero, Objeto[] objetosEnTablero) {
        //Rellenamos con asteriscos
        for (int i = 0; i < superficie.length; i++)
            for (int j = 0; j < superficie[i].length; j++)
                superficie[i][j] = "*";

        //Recorremos vector de objetos
        for (int i = 0; i < objetosEnTablero.length; i++) {
            //Pelota
            if (objetosEnTablero[i] instanceof Pelota)
                superficie[objetosEnTablero[i].getPosX()][objetosEnTablero[i].getPosY()] = "PE" + i;

            //Poligono plano
            if (objetosEnTablero[i] instanceof PoligonoPlano)
                superficie[objetosEnTablero[i].getPosX()][objetosEnTablero[i].getPosY()] = "PP" + i;
        }

        //Recorremos el vector de robots
        for (int i = 0; i < robotsEnTablero.length; i++) {
            //Robot cogedor
            if (robotsEnTablero[i] instanceof RobotCogedor)
                superficie[robotsEnTablero[i].getPosX()][robotsEnTablero[i].getPosY()] = "RC" + i;

            //Robot disparador
            if (robotsEnTablero[i] instanceof RobotDisparador)
                superficie[robotsEnTablero[i].getPosX()][robotsEnTablero[i].getPosY()] = "RD" + i;
        }
    }

    private static void mostrarMatriz(String[][] superficie) {
        System.out.println("   0     1     2     3     4     5     6     7     8     9");
        for (int i = 0; i < superficie.length; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < superficie[i].length; j++) {
                if (superficie[i][j].equals("*"))
                    System.out.print(" " + superficie[i][j] + "    ");
                else
                    System.out.print(" " + superficie[i][j] + "  ");
            }
            System.out.println();
        }
    }

    private static void mostrarMenuMovimientoRobot(){
        System.out.println("\n1.IZQUIERDA");
        System.out.println("2.DERECHA");
        System.out.println("3.ARRIBA");
        System.out.println("4.ABAJO");
        System.out.println("5. SALIR\n");
    }

    private static void mostrarMenuPrincipal() {
        System.out.println("\na. MOSTRAR ROBOT");
        System.out.println("b. MOSTRAR OBJETOS DEL ROBOT");
        System.out.println("c. MOVER ROBOT");
        System.out.println("d. SALIR\n");
    }

    private static void mostrarDatosRobot(int robot, Robot[] robots) {
        robots[robot].mostrarRobot();
    }

    private static void mostrarMenuObjetosRobot() {
        System.out.println("\np (peso)");
        System.out.println("v (volumen)");
        System.out.println("a (area)\n");
    }
}
