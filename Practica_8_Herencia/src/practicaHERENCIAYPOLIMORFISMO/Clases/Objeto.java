package practicaHERENCIAYPOLIMORFISMO.Clases;

public abstract class Objeto {
    //Atributos
    private int posX;
    private int posY;
    private float peso;

    //Constructores
    public Objeto(int posX, int posY, float peso) {
        this.posX = posX;
        this.posY = posY;
        this.peso = peso;
    }

    //Metodos consultores
    public int getPosX() {
        return posX;
    }

    public int getPosY() {
        return posY;
    }

    public float getPeso() {
        return peso;
    }

    //Metodos sobrescritos
    @Override
    public String toString() {
        return("\nPOSICION X: "+posX+"\n"+
               "POSICION Y: "+posY+"\n"+
               "PESO: "+peso);
    }
}
