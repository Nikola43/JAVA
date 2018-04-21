package practicaHERENCIAYPOLIMORFISMO.Tests;

import practicaHERENCIAYPOLIMORFISMO.Clases.Pelota;
import practicaHERENCIAYPOLIMORFISMO.Clases.RobotCogedor;

import java.awt.*;

public class TestRobot {
    public static void main(String[] args) {
        RobotCogedor robotCogedor = new RobotCogedor(4, 4, 5);
        Pelota pelota = new Pelota(6, 5, 6, 9);
        Pelota pelota1 = new Pelota(6, 5, 6, 9);
        Pelota pelota2 = new Pelota(6, 5, 6, 9);
        Pelota pelota3 = new Pelota(6, 5, 6, 9);

        System.out.println(robotCogedor.coger(pelota));
        System.out.println(robotCogedor.coger(pelota1));
        System.out.println(robotCogedor.coger(pelota2));
        System.out.println(robotCogedor.coger(pelota3));



        System.out.println(robotCogedor.soltar(pelota2));

        System.out.println(robotCogedor.hayHuecoLibreVectorObjetos());

        System.out.println(robotCogedor.soltar(pelota1));



        robotCogedor.reagruparObjetos();

        System.out.println(robotCogedor.hayHuecoLibreVectorObjetos());
    }
}
