package practicaHERENCIAYPOLIMORFISMO.Tests;

import practicaHERENCIAYPOLIMORFISMO.Clases.Pelota;
import practicaHERENCIAYPOLIMORFISMO.Clases.PoligonoPlano;
import practicaHERENCIAYPOLIMORFISMO.Clases.RobotCogedor;

public class TestRobot {
    public static void main(String[] args) {
        RobotCogedor robotCogedor = new RobotCogedor(4, 4, 5);
        Pelota pelota = new Pelota(6, 5, 2, 9);
        Pelota pelota1 = new Pelota(6, 5, 7, 4);
        PoligonoPlano poligonoPlano = new PoligonoPlano(6, 5, 3,7,3);
        PoligonoPlano poligonoPlano2 = new PoligonoPlano(6, 5, 6,6,8);

        System.out.println(robotCogedor.coger(pelota));
        System.out.println(robotCogedor.coger(pelota1));
        System.out.println(robotCogedor.coger(poligonoPlano));
        System.out.println(robotCogedor.coger(poligonoPlano2));

        robotCogedor.mostrarObjetosCogidos();
        robotCogedor.ordenarObjetosCogidosPorAreaYVolumen();
        robotCogedor.mostrarObjetosCogidos();


        System.out.println(robotCogedor.soltar(poligonoPlano));

        System.out.println(robotCogedor.soltar(pelota1));



        robotCogedor.reagruparObjetos();


        robotCogedor.mostrarRobot();

    }
}
