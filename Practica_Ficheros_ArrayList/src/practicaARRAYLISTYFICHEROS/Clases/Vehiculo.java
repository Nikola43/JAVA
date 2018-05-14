/*
Vehiculo (0.25 puntos): Los objetos de esta clase deben poder guardarse en ficheros.
Tiene los atributos matricula, modelo, plazas y un booleano disponible.
Tiene el constructor con parámetros y el constructor copia
(en el copia pide una nueva matrícula en el método que se la asigna al atributo correspondiente,
copia el modelo y las plazas y pone a disponible el nuevo vehículo). También tiene los getters y setters.
 El resto de métodos son:
     ponerOcupado y ponerDisponible: que ponen respectivamente a false o a true el atributo disponible.
     toString: Reescribe el método toString() heredado de la clase Object, devolviendo una cadena con matricula,
    modelo, plazas y si está disponible el vehículo (con un SI o NO en caso de estar o no disponible,
    no vale poner TRUE o FALSE). Por ejemplo:
     costeAlquiler: es un método abstracto para calcular el coste del alquiler de los vehículos,
     no recibe parámetros ni devuelve nada.
 */
package practicaARRAYLISTYFICHEROS.Clases;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Serializable;

public abstract class Vehiculo implements Serializable{
    //Atributos
    private String  matricula;
    private String  modelo;
    private int     plazas;
    private boolean disponible;
    private static final long serialVersionUID = 1L;

    //Constuctores
    public Vehiculo(String matricula, String modelo, int plazas, boolean disponible) {
        this.matricula = matricula;
        this.modelo = modelo;
        this.plazas = plazas;
        this.disponible = disponible;
    }

    public Vehiculo(Vehiculo v){
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        String matriculaNueva = " ";

        //Pedimos nueva matricula al usuario
        try {
            matriculaNueva = bufferedReader.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        }

        this.matricula = matriculaNueva;
        this.modelo = v.modelo;
        this.plazas = v.plazas;
        this.disponible = true;
    }

    //Getters
    public String getMatricula() {
        return matricula;
    }
    public String getModelo() {
        return modelo;
    }
    public int getPlazas() {
        return plazas;
    }
    public boolean isDisponible() {
        return disponible;
    }

    //Setters
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

    //Metodos añadidos
    public void ponerOcupado(){
        disponible = false;
    }
    public void ponerDisponible(){
        disponible = true;
    }

    public abstract void costeAlquiler();

    //Metodos sobrescritos
    @Override
    public String toString() {
        return "Matricula: "+matricula+"\n"+
                "Modelo: "+modelo+"\n"+
                "Plazas: "+plazas+"\n"+
                "Disponible: "+(disponible ? "SI" : "NO");
    }
}
