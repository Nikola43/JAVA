/*
 Interfaz IAltasYBajas: tiene un método alta al que se le pasa como parámetro un
 objeto del tipo del que se quiere dar el alta y devuelve un booleano.
 Tiene también otro método baja que se le pasa un String identificador
 como parámetro y devuelve otro booleano.
 */

package practicaARRAYLISTYFICHEROS.Interfaces;
import practicaARRAYLISTYFICHEROS.Clases.Vehiculo;

public interface IAltasYBajas {
    boolean alta(Object obj);
    boolean baja(Object obj);
}
