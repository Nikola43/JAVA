package practicaHERENCIAYPOLIMORFISMO.Tests;

import practicaHERENCIAYPOLIMORFISMO.Clases.PoligonoPlano;

public class TestPoligonoPlano {
    public static void main(String[] args) {
        PoligonoPlano poligonoPlano = new PoligonoPlano(3, 2, 8, 2, 3);

        System.out.println("PosX: "+poligonoPlano.getPosX());
        System.out.println("PosY: "+poligonoPlano.getPosY());
        System.out.println("Peso: "+poligonoPlano.getPeso());
        System.out.println("Area: "+poligonoPlano.calcularArea()+"\n");
        System.out.println("toString: "+poligonoPlano.toString());
    }
}
