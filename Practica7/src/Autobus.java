

public class Autobus {
    String matricula;
    Conductor conductor;


    public String getMatricula() {
        return matricula;
    }

    public Conductor getConductor() {
        return conductor;
    }

    public void setConductor(Conductor conductor) {
        this.conductor = conductor;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
}





/*
        Contendrá como atributos una matricula, un objeto tipo Conductor, ciudadDondeEsta que
        indica la ciudad donde se encuentra actualmente el autobús y kilometrosAutobus. Todos
        estos atributos no serán visibles desde ninguna clase externa.En esta clase existirá el constructor vacío que asignará a matricula una cadena vacía, a ciudad
        una cadena vacía también y a kilometrosAutobus un valor 0. También habrá un constructor
        con los parámetros mat para la matrícula y ciudad para la ciudadDondeEstá. Los
        kilometrosAutobus se inicializarán a 0 dentro de este constructor. El conductor será asignado
        sólo cuando el autobús vaya a realizar un viaje, por lo que no se crea ningún objeto Conductor
        dentro de ninguno de los constructores.
        Habrá getters y setters para todos los atributos.
        (atributos, constructores, getters y setters: 0.25 puntos)
        El resto de métodos serán los siguientes:
        asignarConductor(0.5 puntos): se le pasa como parámetro un objeto Conductor y los
        kilómetros que se harán en el viaje. Si el conductor pasado como parámetro puede hacer el
        viaje, se asigna al atributo conductor y devuelve true. Si no puede hacer el viaje no hace nada y
        devuelve false.
        hacerViaje(0.75 puntos): Se le pasan como parámetros los kilómetros del viaje y la ciudad de
        destino. El método añade los kilómetros al atributo Conductor y también suma a su atributo
        kilometrosAutobus los kilómetros del viaje. Luego modifica el atributo ciudadDondeEsta y le
        asigna la ciudad de destino. Por último, cambia la ciudadAlojamiento del Conductor a la ciudad
        de destino.
        liberarConductor(0.25 puntos): Lo único que hace es poner a null el atributo Conductor.
        mostrarDatosAutobus (0. 5 puntos): No devuelve nada. Mostrará los datos del autobús tal y
        como aparece abajo:
        Además, si tuviera asignado algún conductor el objeto autobús, mostraría justo después de los
        datos del autobús los datos del conductor, así:
*/
