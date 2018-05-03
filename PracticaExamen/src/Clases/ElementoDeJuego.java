package Clases;

import Interfaces.Ijugable;

/*
 * Clase Clases.ElementoDeJuego: Tiene un atributo identificador tipo String y otro atributo resultado tipo int que
almacenar� el valor correspondiente cuando haya una tirada. Tiene constructor con el par�metro identificador,
getters y setters y la redefinici�n del m�todo toString de la clase Object que muestra el identificador del objeto
correspondiente.
 */
public abstract class ElementoDeJuego implements Ijugable {
	private String identificador;
	private int resultado;
	
	public ElementoDeJuego(String identificador) {
		this.identificador = identificador;
	}

	//redefinici�n del m�todo toString de la clase Object
	@Override
	public String toString() {
		return "Identificador: "+this.identificador;
	}
	public String getIdentificador() {
		return identificador;
	}

	public void setIdentificador(String identificador) {
		this.identificador = identificador;
	}

	public int getResultado() {
		return resultado;
	}

	public void setResultado(int resultado) {
		this.resultado = resultado;
	}
	
	
}
