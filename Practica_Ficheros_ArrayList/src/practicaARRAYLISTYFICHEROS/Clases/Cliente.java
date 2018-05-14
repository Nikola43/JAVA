package practicaARRAYLISTYFICHEROS.Clases;

/*
Cliente (0.25 puntos): que tiene los atributos DNI, Nombre y Apellidos. Además de
los constructores con parámetros y copia, tiene los getters y setters. Además reescribe el método toString()
heredado de la clase Object. Los objetos de esta clase deben poder guardarse en un fichero.
 */

import java.io.Serializable;

public class Cliente implements Serializable{
    //Atributos
    private String DNI;
    private String nombre;
    private String apellidos;
    private static final long serialVersionUID = 1L;

    //Constructores
    public Cliente(String DNI, String nombre, String apellidos) {
        this.DNI = DNI;
        this.nombre = nombre;
        this.apellidos = apellidos;
    }
    public Cliente(Cliente c){
        this.DNI = c.DNI;
        this.nombre = c.nombre;
        this.apellidos = c.apellidos;
    }

    //Getters
    public String getDNI() {
        return DNI;
    }
    public String getNombre() {
        return nombre;
    }
    public String getApellidos() {
        return apellidos;
    }

    //Settters
    public void setDNI(String DNI) {
        this.DNI = DNI;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    //Metodos sobrescritos
    @Override
    public String toString() {
        return DNI+","+nombre+","+apellidos;
    }
}
