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

        //Ajustamos tablero y lo mostramos
        ajustarTablero(superficie, robots, objetos);
        mostrarMatriz(superficie);

        //Pedimos al usuario que elija el robot que va a utilizar
        for (int i = 0; i < robots.length; i++) {
            System.out.println((i+1)+" ----------------- ");
            robots[i].mostrarRobot();
        }
        System.out.print("Elige el robot que quieres usar (1-"+robots.length+"): ");
        robotElegido = Integer.parseInt(bufferedReader.readLine()) - 1;

        //Mostramos menu al usuario
        mostrarMenuPrincipal();
        System.out.print("¿Que desea hacer?: ");
        opcionMenuPrincipal = Character.toLowerCase(bufferedReader.readLine().charAt(0));

        switch (opcionMenuPrincipal){
            case 'a' : robots[robotElegido].mostrarRobot(); break;
            case 'b' :

                break;
        }

        //Mostrar objetos del robot
        if (robots[robotElegido] instanceof RobotCogedor){
            System.out.println("p (peso)");
            System.out.println("v (volumen)");
            System.out.println("a (area)");
            System.out.println("Como quiere ordenar los objetos(p): ");
        }
        else
            System.out.println("No es un robot cogedor");



    }

    public static void ajustarTablero(String[][] superficie, Robot[] robotsEnTablero, Objeto[] objetosEnTablero) {
        //Rellenamos con asteriscos
        for (int i = 0; i < superficie.length; i++)
            for (int j = 0; j < superficie[i].length; j++)
                superficie[i][j] = "*";

        //Recorremos vector de objetos
        for (Objeto objetoActual : objetosEnTablero) {
            //Pelota
            if (objetoActual instanceof Pelota)
                superficie[objetoActual.getPosX()][objetoActual.getPosY()] = "PE";

            //Poligono plano
            if (objetoActual instanceof PoligonoPlano)
                superficie[objetoActual.getPosX()][objetoActual.getPosY()] = "PP";
        }
        
        //Recorremos el vector de robots
        for (Robot robotActual : robotsEnTablero) {
            //Robot cogedor
            if (robotActual instanceof RobotCogedor)
                superficie[robotActual.getPosX()][robotActual.getPosY()] = "RC";

            //Robot disparador
            if (robotActual instanceof RobotDisparador)
                superficie[robotActual.getPosX()][robotActual.getPosY()] = "RD";
        }
    }

    private static void mostrarMatriz(String[][] superficie){
        System.out.println("   0     1     2     3     4     5     6     7     8     9");
        for (int i = 0; i < superficie.length; i++) {
            System.out.print(i+" ");
            for (int j = 0; j < superficie[i].length; j++) {
                if (superficie[i][j].equals("*"))
                    System.out.print(" "+superficie[i][j] + "    ");
                else
                    System.out.print(" "+superficie[i][j] + "   ");
            }
            System.out.println();
        }
    }

    private static void mostrarMenuPrincipal(){
        System.out.println("a. MOSTRAR ROBOT");
        System.out.println("a. MOSTRAR OBJETOS DEL ROBOT");
        System.out.println("a. MOVER ROBOT");
    }
}
