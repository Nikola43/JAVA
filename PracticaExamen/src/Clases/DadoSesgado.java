package Clases;/*Tiene los atributos probabilidad1, probabilidad2, probabilidad3, probabilidad4,
probabilidad5 y probabilidad6, todos tipo double. Tiene el constructor con parámetros al que se le pasa el
identificador y un valor para cada uno de los atributos de las probabilidades (suponemos que el usuario es buena
gente y la suma de todas esas probabilidades es 1). Implementa el método tirada, en función de los atributos
probabilidades cada número tendrá esa probabilidad de salir a partir del uso del método random, según el valor,
da al atributo resultado un valor entre 1 y 6. Implementa el método mostrarResultadoTirada, si el valor del
atributo resultado es 1 escribe HA SALIDO UN UNO, si es 2 escribe HA SALIDO UN DOS...y así
sucesivamente.*/

public class DadoSesgado extends ElementoDeJuego {
    private double probabilidad1;
    private double probabilidad2;
    private double probabilidad3;
    private double probabilidad4;
    private double probabilidad5;
    private double probabilidad6;
    private double provabilidad5;

    public DadoSesgado(String identificador, double pro1, double pro2, double pro3,
                       double pro4, double pro5, double pro6) {
        super(identificador);
        this.probabilidad1 = pro1;
        this.probabilidad2 = pro2;
        this.probabilidad3 = pro3;
        this.probabilidad4 = pro4;
        this.probabilidad5 = pro5;
        this.probabilidad6 = pro6;

    }

    @Override
    public void tirada() {
        double numero = Math.random();
        if (numero>=0 && numero < this.probabilidad1)
            super.setResultado(1);
        else if (numero>=probabilidad1 && numero<probabilidad1+probabilidad2)
            super.setResultado(2);
        else if (numero>=probabilidad2 && numero<probabilidad1+probabilidad2+probabilidad3)
            super.setResultado(3);
        else if (numero>=probabilidad3 && numero<probabilidad1+probabilidad2+probabilidad3+probabilidad4)
            super.setResultado(4);
        else if (numero>=probabilidad4 && numero<probabilidad1+probabilidad2+probabilidad3+probabilidad4+provabilidad5)
            super.setResultado(5);
        else if (numero>=provabilidad5 && numero<probabilidad1+probabilidad2+probabilidad3+probabilidad4+provabilidad5+probabilidad6)
            super.setResultado(6);
    }

    @Override
    public void mostrarResultadoTirada() {
        if (super.getResultado()== 1) {
            System.out.println("HA SALIDO UN UNO");
        }
        if (super.getResultado() == 2) {
            System.out.println("HA SALIDO UN DOS");
        }
        if (super.getResultado() == 3) {
            System.out.println("HA SALIDO UN TRES");
        }
        if (super.getResultado() == 4) {
            System.out.println("HA SALIDO UN CUATRO");
        }
        if (super.getResultado()==5) {
            System.out.println("HA SALIDO UN CINCO");
        }
        if (super.getResultado()==6) {
            System.out.println("HA SALIDO UN SEIS");
        }
    }

    public double getProbabilidad1() {
        return probabilidad1;
    }

    public void setProbabilidad1(double probabilidad1) {
        this.probabilidad1 = probabilidad1;
    }

    public double getProbabilidad2() {
        return probabilidad2;
    }

    public void setProbabilidad2(double probabilidad2) {
        this.probabilidad2 = probabilidad2;
    }

    public double getProbabilidad3() {
        return probabilidad3;
    }

    public void setProbabilidad3(double probabilidad3) {
        this.probabilidad3 = probabilidad3;
    }

    public double getProbabilidad4() {
        return probabilidad4;
    }

    public void setProbabilidad4(double probabilidad4) {
        this.probabilidad4 = probabilidad4;
    }

    public double getProbabilidad5() {
        return probabilidad5;
    }

    public void setProbabilidad5(double probabilidad5) {
        this.probabilidad5 = probabilidad5;
    }

    public double getProbabilidad6() {
        return probabilidad6;
    }

    public void setProbabilidad6(double probabilidad6) {
        this.probabilidad6 = probabilidad6;
    }

}