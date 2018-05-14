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

public class Alquiler implements IAlquilable, Serializable{
    //Atributos
    private static final long serialVersionUID = 1L;

    @Override
    public void realizarAlquiler() {

    }

    @Override
    public void devolucionAlquiler() {

    }
}
