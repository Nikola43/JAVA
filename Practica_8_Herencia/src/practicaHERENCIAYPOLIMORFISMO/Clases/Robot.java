package practicaHERENCIAYPOLIMORFISMO.Clases;

import practicaHERENCIAYPOLIMORFISMO.Interfaces.IMovible;

public abstract class Robot implements IMovible {
    //Atributos
    public static int numeroRobots = 0;
    private int posX;
    private int posY;

    //Constructores
    Robot(int posX, int posY){
        this.posX = posX;
        this.posY = posY;
    }

    Robot(Robot robotCopia){
        this.posX = robotCopia.posX;
        this.posY = robotCopia.posY;
    }

    //Metodos consultores
    public int getPosX() {
        return posX;
    }

    public int getPosY() {
        return posY;
    }

    public int getNumeroRobots() {
        return numeroRobots;
    }

    //Metodos sobrescritos
    @Override
    public boolean avanzarEjeX(int sumX, int fronteraX) {
        boolean resultado = false;

        if (posX + sumX <= fronteraX) {
            posX += sumX;
            resultado = true;
        }
        return resultado;
    }

    @Override
    public boolean avanzarEjeY(int sumY, int fronteraY) {
        boolean resultado = false;

        if (posY + sumY <= fronteraY) {
            posY += sumY;
            resultado = true;
        }
        return resultado;
    }

    @Override
    public boolean retrocederEjeX(int resX, int fronteraNegativaX) {
        boolean resultado = false;

        if (posX - resX >= fronteraNegativaX) {
            posX -= resX;
            resultado = true;
        }
        return resultado;
    }

    @Override
    public boolean retrocederEjeY(int resY, int fronteraNegativaY) {
        boolean resultado = false;

        if (posY - resY >= fronteraNegativaY) {
            posY -= resY;
            resultado = true;
        }
        return resultado;
    }

    //Metodos añadidos
    public void mostrarRobot(){
        System.out.println("POSICION X: "+posX);
        System.out.println("POSICION Y: "+posY);
    }

    public abstract void movimientoDiagonal(int numeroPasos, String movimiento, int frontX, int frontY, int frontNegX, int frontNegY);
}
