public class Semaforo {
    //Atributos
    private char color;

    //Constructores
    //Constructor vacio
    public Semaforo()
    {
        color = '\0';
    }

    //Constructor por defecto
    public Semaforo(char color)
    {
        this.color = color;
    }

    //Constructor de copia
    public Semaforo(Semaforo semaforo)
    {
        this.color = semaforo.color;
    }

    //Metodos consultores
    public char getColor() {
        return color;
    }

    //Metodos modificadores
    public void setColor(char color) {
        this.color = color;
    }

    //metodos añadidos
    public void setColorRojo()
    {
        color = 'R';
    }

    public void setColorAmarillo() {
        color = 'A';
    }

    public void setColorVerde() {
        color = 'V';
    }

    public boolean estaRojo() {
        return color == 'R';
    }

    public boolean estaAmarillo() {
        return color == 'A';
    }

    public boolean estaVerde() {
        return color == 'V'
    }
}
