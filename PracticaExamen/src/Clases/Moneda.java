package Clases;

import Clases.ElementoDeJuego;

/*
 * random si sale un valor menor a 0.5 le dar� un valor 0 al atributo resultado y si sale un valor mayor o igual a 0.5 le
dar� un valor 1 al atributo resultado. Implementa el m�todo mostrarResultadoTirada, si el valor del atributo
resultado es 0 escribe �HA SALIDO CARA� y si el valor del atributo resultado es 1 escribe �HA SALIDO
CRUZ�.
 */
public class Moneda extends ElementoDeJuego {

	public Moneda(String identificador) {
		super(identificador);
	}

	@Override
	public void tirada() {
		if (Math.random() >= 0.5)
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
		return "Clases.Moneda" + super.toString();
	}
}
