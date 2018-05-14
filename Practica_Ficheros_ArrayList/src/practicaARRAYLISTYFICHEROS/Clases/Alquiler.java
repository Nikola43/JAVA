/*
Alquiler (0.25 puntos): los objetos de esta clase deben poder guardarse en ficheros.
Tiene como atributos el dni del cliente que tiene hecho el alquiler y un arrayList tipo String
 donde se guardan las matrículas de los vehículos que el cliente tiene alquilados
  (no existe un máximo de vehículos que pueda tener alquilados a la vez).

  El constructor con parámetros recibe el dni del cliente para asignárselo al atributo correspondiente
  y crea el objeto arrayList para las matrículas de los coches alquilados.

   Tiene el getDNICliente que devuelve el DNI del cliente al que corresponde dicho alquiler
   y getListaVehiculosAlquilados que devuelve el atributo arrayList de matrículas completo.
    Los otros dos métodos que tiene son:
 anyadeVehiculo (0.25 puntos): que añade la matrícula pasada como
   parámetro al arrayList de matriculas. No devuelve nada.
 devuelveVehiculo (0.25 puntos): que recibe una matrícula y la borra del arrayList
   de matrículas devolviendo true en caso que existiera y la hubiera podido borrar y false en caso contrario.
 */

package practicaARRAYLISTYFICHEROS.Clases;
import practicaARRAYLISTYFICHEROS.Interfaces.IAlquilable;

import java.io.Serializable;
import java.util.ArrayList;

public class Alquiler implements  Serializable{
    //Atributos
    private String dniCliente;
    private ArrayList<String> matriculasVehiculosAlquilados;
    private static final long serialVersionUID = 1L;

    //Constructores
    public Alquiler(String dniCliente) {
        this.dniCliente = dniCliente;
        this.matriculasVehiculosAlquilados = new ArrayList<>();
    }

    //Getters
    public String getDniCliente() {
        return dniCliente;
    }

    public ArrayList<String> getMatriculasVehiculosAlquilados() {
        return matriculasVehiculosAlquilados;
    }

    //Metodos añadidos
    public void ayadeVehiculo(String matricula){
        matriculasVehiculosAlquilados.add(matricula);
    }

    public void devuelveVehiculo(String matricula){
        ArrayList<String> aux = new ArrayList<>();

        //Metemos en el array todos los elementos menos el que queremos borrar
        for (String vehiculoActual: matriculasVehiculosAlquilados)
            if (!vehiculoActual.equals(matricula))
                aux.add(vehiculoActual);

        //Asignamos los vehiculos que quedan a la lista de vehiculos alquilados
        matriculasVehiculosAlquilados = aux;
    }
}
