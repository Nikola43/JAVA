/*
Furgoneta (0.25 puntos): Tiene los nuevos atributos kilometraje, precioBajoKilometraje,
precioMedioKilometraje, precioAltoKilometraje. Amplia los constructores con parámetros
y copia con los nuevos atributos. Tiene los getters y setters. Amplia el método toString
añadiendo a la cadena el kilometraje de la furgoneta así como los precios por cada kilometraje.
Así:
El resto de métodos son:
 El método anyadirKilometros que recibe como parámetro un número de kilómetros y se
 los suma al kilometraje de la furgoneta.
 El método costeAlquiler pregunta al usuario el kilometraje actual de la furgoneta.
 Calcula los kilómetros hechos, añade los kilómetros a la furgoneta con el método correspondiente
  y muestra por pantalla el coste del alquiler en función de los kilómetros hechos (bajo kilometraje
   menor o igual a 500km, medio kilometraje entre 501 y 1500km, alto kilometraje más de 1500km).
 */
package practicaARRAYLISTYFICHEROS.Clases;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Furgoneta extends Vehiculo{
    //Atributos
    private double kilometraje;
    private double precioBajoKilometraje;
    private double precioMedioKilometraje;
    private double precioAltoKilometraje;

    //Constructores
    public Furgoneta(String matricula, String modelo, int plazas, boolean disponible) {
        super(matricula, modelo, plazas, disponible);
    }

    public Furgoneta(Furgoneta f) {
        super(f);
        this.kilometraje = f.kilometraje;
        this.precioBajoKilometraje = f.precioBajoKilometraje;
        this.precioMedioKilometraje = f.precioMedioKilometraje;
        this.precioAltoKilometraje = f.precioAltoKilometraje;
    }

    //Getters
    public double getKilometraje() {
        return kilometraje;
    }

    public double getPrecioBajoKilometraje() {
        return precioBajoKilometraje;
    }

    public double getPrecioMedioKilometraje() {
        return precioMedioKilometraje;
    }

    public double getPrecioAltoKilometraje() {
        return precioAltoKilometraje;
    }

    //Setters
    public void setKilometraje(double kilometraje) {
        this.kilometraje = kilometraje;
    }

    public void setPrecioBajoKilometraje(double precioBajoKilometraje) {
        this.precioBajoKilometraje = precioBajoKilometraje;
    }

    public void setPrecioMedioKilometraje(double precioMedioKilometraje) {
        this.precioMedioKilometraje = precioMedioKilometraje;
    }

    public void setPrecioAltoKilometraje(double precioAltoKilometraje) {
        this.precioAltoKilometraje = precioAltoKilometraje;
    }

    //Metodos heredados
    @Override
    public void costeAlquiler() {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        double kilometrajeActual = 0;
        double diferencia = 0;

        //Pedimos al usuario que introduza los kilometros que lleva hasta el momento
        System.out.print("Introduzca el kilometraje actual de la furgoneta: ");
        try {
            kilometrajeActual = Double.parseDouble(bufferedReader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }

        //Calulamos la diferencia
        diferencia = kilometrajeActual - kilometraje;

        //Añadimos los kilometros
        ayadirKilometros(diferencia);

        //Mostramos precio segun la tarifa de kilometros
        if (diferencia < 500)
            System.out.println("Precio total: "+(diferencia * precioBajoKilometraje));

        if (diferencia > 501 && kilometraje < 1500)
            System.out.println("Precio total: "+(diferencia * precioMedioKilometraje));

        if (diferencia > 1500)
            System.out.println("Precio total: "+(diferencia * precioAltoKilometraje));
    }

    @Override
    public String toString() {
        return super.toString()+"\n\n"+
                "KILOMETRAJE: "+kilometraje+"\n\n"+
                "PRECIO BAJO KILOMETRAJE(menor o igual a 500km): "+precioBajoKilometraje+"\n"+
                "PRECIO MEDIO KILOMETRAJE(entre 501 y 1500km): "+precioMedioKilometraje+"\n"+
                "PRECIO MEDIO KILOMETRAJE(mas de 1500km): "+precioAltoKilometraje+"\n";
    }

    public void ayadirKilometros(double kilometros){
        kilometraje += kilometros;
    }


}
