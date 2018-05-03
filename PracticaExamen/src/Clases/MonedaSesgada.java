package Clases;

import Clases.ElementoDeJuego;

/*
 * Clase Clases.MonedaSesgada: Tiene un atributo tipo double llamado sesgo. Tiene el constructor con par�metros al
que se le pasa el valor para identificador y el valor para sesgo. Implementa el m�todo tirada, a partir de un
random, si sale un valor menor que el sesgo dar� un valor de 0 al atributo resultado y si sale un valor mayor o
igual al sesgo dar� un valor 1 al atributo resultado. Implementa el m�todo mostrarResultadoTirada, si el valor
del atributo resultado es 0 escribe �HA SALIDO CARA� y si el valor del atributo resultado es 1 escribe �HA
SALIDO CRUZ�.
 */
public class MonedaSesgada extends ElementoDeJuego {
	private double sesgo;
	
	public MonedaSesgada(String identificador, double sesgo) {
		super(identificador);
		this.sesgo = sesgo;
	}

	@Override
	public void tirada() {
		if (Math.random() >= sesgo)
			super.setResultado(1);
		else
			super.setResultado(0);
	}

	@Override
	public void mostrarResultadoTirada() {
		if (super.getResultado() == 1 )
			System.out.println("HA SALIDO CRUZ");
		if (super.getResultado() == 0 )
			System.out.println("HA SALIDO CARA");
	}

	@Override
	public String toString() {
		return "Clases.Moneda Sesgada" + super.toString();
	}

	public double getSesgo() {
		return sesgo;
	}
	public void setSesgo(double sesgo) {
		this.sesgo = sesgo;
	}
}
