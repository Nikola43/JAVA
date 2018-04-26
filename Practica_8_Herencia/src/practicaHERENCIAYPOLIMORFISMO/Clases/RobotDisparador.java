package practicaHERENCIAYPOLIMORFISMO.Clases;

import practicaHERENCIAYPOLIMORFISMO.Interfaces.IDisparable;
import practicaHERENCIAYPOLIMORFISMO.Interfaces.IMovible;

public class RobotDisparador extends Robot implements IMovible, IDisparable {
    //Atributos
    private int distanciaDisparo;
    private char posicionDisparo;
    private int numeroDisparosAcertados;

    //Constructores
    public RobotDisparador(int posY, int posX, int distanciaDisparo, char posicionDisparo) {
        super(posY, posX);
        this.distanciaDisparo = distanciaDisparo;
        this.posicionDisparo = posicionDisparo;
    }

    //Metodos consultores

    public int getDistanciaDisparo() {
        return distanciaDisparo;
    }

    public char getPosicionDisparo() {
        return posicionDisparo;
    }

    public int getNumeroDisparosAcertados() {
        return numeroDisparosAcertados;
    }

    //Metodos heredados
    @Override
    public void movimientoDiagonal(int numeroPasos, String movimiento, int frontX, int frontY, int frontNegX, int frontNegY) {

    }

    @Override
    public boolean disparar(Objeto obj) {
        boolean sePuedeDisparar = false;

        // Este
        if (posicionDisparo == 'e'                  //Si la posición de disparo es E (este)
                && this.getPosY() == obj.getPosY()  //Si objeto y robot están en la misma coordenada Y
                && obj.getPosX() > this.getPosX()   //Si la coordenada X del objeto es mayor que la del robot
                && this.getPosX() + distanciaDisparo <= obj.getPosX()) //Si la distancia entre objeto y robot es menor o igual que la distancia de disparo
        {
            numeroDisparosAcertados++;
            sePuedeDisparar = true;
        }

        // Oeste
        if (posicionDisparo == 'o'                  //Si la posición de disparo es O (oeste)
                && this.getPosY() == obj.getPosY()  //Si objeto y robot están en la misma coordenada Y
                && obj.getPosX() < this.getPosX()   //Si la coordenada X del robor es mayor que la del objeto
                && this.getPosX() + distanciaDisparo <= obj.getPosX()) //Si la distancia entre objeto y robot es menor o igual que la distancia de disparo
        {
            numeroDisparosAcertados++;
            sePuedeDisparar = true;
        }

        // Norte
        if (posicionDisparo == 'n'                  //Si la posición de disparo es N (norte)
                && this.getPosX() == obj.getPosX()  //Si objeto y robot están en la misma coordenada X
                && obj.getPosY() > this.getPosY()   //Si la coordenada Y del objeto es mayor que la del robot
                && this.getPosY() + distanciaDisparo <= obj.getPosY()) //Si la distancia entre objeto y robot es menor o igual que la distancia de disparo
        {
            numeroDisparosAcertados++;
            sePuedeDisparar = true;
        }

        if (posicionDisparo == 's'                  //Si la posición de disparo es E (este)
                && this.getPosX() == obj.getPosX()  //Si objeto y robot están en la misma coordenada Y
                && obj.getPosY() < this.getPosY()   //Si la coordenada Y del robot es mayor que la del objeto
                && this.getPosY() + distanciaDisparo <= obj.getPosY()) //Si la distancia entre objeto y robot es menor o igual que la distancia de disparo
        {
            numeroDisparosAcertados++;
            sePuedeDisparar = true;
        }

        return sePuedeDisparar;
    }

    //Metodos añadidos
    public boolean cambiarPosicionDisparo(char posicionDisparo) {
        boolean sePuedeCambiar = false;

        if (posicionDisparo == 'n' || posicionDisparo == 's' || posicionDisparo == 'e' || posicionDisparo == 'o')
        {
            this.posicionDisparo = posicionDisparo;
            sePuedeCambiar = true;
        }

        return sePuedeCambiar;
    }

    @Override
    public void mostrarRobot() {
        System.out.println("ROBOT DISPARADOR\n");
        super.mostrarRobot();
        System.out.println("\nDISTANCIA DE TIRO: "+distanciaDisparo);
        System.out.println("DISPAROS ACERTADOS: "+numeroDisparosAcertados);
    }
}
