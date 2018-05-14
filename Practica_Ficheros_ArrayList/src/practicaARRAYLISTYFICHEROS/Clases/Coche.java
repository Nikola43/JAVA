/*
 Coche (0.25 puntos): Tiene un nuevo atributo precioPorDia. El constructor con parámetros y el constructor copia.
 Getters, setters, añade a la cadena devuelta por toString() del padre el precio por día. Por ejemplo:
  El método costeAlquiler pregunta al usuario cuantos días ha estado alquilado el coche,
 y muestra por pantalla el coste del alquiler.
 */

package practicaARRAYLISTYFICHEROS.Clases;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Coche extends Vehiculo{
    //Atributos
    double precioPorDia;

    //Constructores
    public Coche(String matricula, String modelo, int plazas, boolean disponible, double precioPorDia) {
        super(matricula, modelo, plazas, disponible);
        this.precioPorDia = precioPorDia;
    }

    public Coche(Coche c) {
        super(c);
        precioPorDia = c.precioPorDia;
    }

    //Getters
    public double getPrecioPorDia() {
        return precioPorDia;
    }

    //Setters
    public void setPrecioPorDia(double precioPorDia) {
        this.precioPorDia = precioPorDia;
    }

    //Metodos sobrescritos
    @Override
    public void costeAlquiler() {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        double numeroDias = 0;

        System.out.print("Introduce el numero de dias que alquiló el coche: ");
        try {
            numeroDias = Double.parseDouble(bufferedReader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Precio total: "+(numeroDias * precioPorDia));
    }

    @Override
    public String toString() {
        return super.toString()+"\n\n"+
                "PRECIO POR DIA: "+precioPorDia;
    }
}
