package Clases;

/*
 * Tiene el constructor con el par�metro identificador. Implementa el m�todo tirada, a partir de un
random, da al atributo resultado un valor entre 1 y 6. Implementa el m�todo mostrarResultadoTirada, si el valor
del atributo resultado es 1 escribe �HA SALIDO UN UNO�, si es 2 escribe �HA SALIDO UN DOS�...y as�
sucesivamente.
 */
public class Dado extends ElementoDeJuego{

	public Dado(String identificador) {
		super(identificador);
	}

    @Override
    public void tirada() {
        int numeroAleatorio = aleatorioRango(1,6);

        if (numeroAleatorio >= 1 && numeroAleatorio <= 6)
            super.setResultado(numeroAleatorio);
    }

    @Override
    public void mostrarResultadoTirada() {
	    String mensaje = "HA SALIDO ";

	    switch (super.getResultado()) {
            case 1 : mensaje += "UNO"; break;
            case 2 : mensaje += "DOS"; break;
            case 3 : mensaje += "TRES"; break;
            case 4 : mensaje += "CUATRO"; break;
            case 5 : mensaje += "CINCO"; break;
            case 6 : mensaje += "SEIS"; break;
        }
        System.out.println(mensaje);
    }

    @Override
    public String toString() {
        return "Clases.Dado " + super.toString();
    }

    private int aleatorioRango(int min, int max) {
        return (int)(Math.random() * ((max - min) + 1)) + min;
    }
}
