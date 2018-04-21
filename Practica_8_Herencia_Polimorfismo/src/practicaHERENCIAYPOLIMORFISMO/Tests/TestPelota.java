package practicaHERENCIAYPOLIMORFISMO.Tests;

import practicaHERENCIAYPOLIMORFISMO.Clases.Pelota;

public class TestPelota {
    public static void main(String[] args) {
        Pelota pelota = new Pelota(4, 5, 6, 9);

        System.out.println("PosX: "+pelota.getPosX());
        System.out.println("PosY: "+pelota.getPosY());
        System.out.println("Peso: "+pelota.getPeso());
        System.out.println("Volumen: "+pelota.calculaVolumen()+"\n");
        System.out.println("toString: "+pelota.toString());
    }
}
