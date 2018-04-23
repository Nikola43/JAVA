package practicaHERENCIAYPOLIMORFISMO.Clases;

public class PoligonoPlano extends Objeto {
    //Atributos
    private float perimetro;
    private float apotema;

    //Constructores
    public PoligonoPlano(int posX, int posY, float peso, float perimetro, float apotema) {
        super(posX, posY, peso);
        this.perimetro = perimetro;
        this.apotema = apotema;
    }

    //Metodos sobrescritos
    @Override
    public String toString() {
        return("\nEL OBJETO ES UN POLIGONO PLANO"+
                super.toString()+"\n"+
                "PERIMETRO: "+perimetro+"\n"+
                "APOTEMA: "+apotema)+"\n"+
                "AREA: "+calcularArea();
    }

    //Metodos añadidos
    public float calcularArea(){
        return ((perimetro * apotema) / 2);
    }
}
