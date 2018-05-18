

import java.io.Serializable;

public class Vehiculo implements Serializable{

	private static final long serialVersionUID = 1L;
	private String matricula;
	private String modelo;
	private int plazas;
	private boolean disponible;
	
	public Vehiculo(String matricula, String modelo, int plazas, boolean disponible){
		this.matricula=matricula;
		this.modelo=modelo;
		this.plazas=plazas;
		this.disponible=disponible;
	}
	
	public String getMatricula() {
		return matricula;
	}
	
	public String getModelo() {
		return modelo;
	}
	
	public int getPlazas() {
		return plazas;
	}

	public boolean getDisponible() {
		return disponible;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}
	
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	
	public void setPlazas(int plazas) {
		this.plazas = plazas;
	}
	
	public void setDisponible(boolean disponible) {
		this.disponible = disponible;
	}
	
	public void ponerOcupado(){
		this.disponible=false;
	}
	
	public void ponerDisponible(){
		this.disponible=true;
	}
	
	public String toString(){
		if (disponible){
			return "MATRICULA: "+getMatricula()+"\nModelo: "+getModelo()+"\nPlazas "+getPlazas()
					+"\nDisponible: SI";
		}
		else {
			return "MATRICULA: "+getMatricula()+"\nModelo: "+getModelo()+"\nPlazas "+getPlazas()
					+"\nDisponible: NO";
		}
	}
}
