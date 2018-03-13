package practica7JAVA;

public class Autobus {
    //Atributos
    private String matricula;
    private Conductor conductor;
    private String ciudadDondeEsta;
    private int kilometrosAutobus;

    //Constructores
    Autobus()
    {
        matricula = "";
        ciudadDondeEsta = "";
        kilometrosAutobus = 0;
    }

    Autobus(String mat, String ciudad)
    {
        matricula = mat;
        ciudadDondeEsta = ciudad;
        kilometrosAutobus = 0;
    }

    //Getters
    public String getMatricula() {
        return matricula;
    }

    public Conductor getConductor() {
        return conductor;
    }

    public String getCiudadDondeEsta() {
        return ciudadDondeEsta;
    }

    public int getKilometrosAutobus() {
        return kilometrosAutobus;
    }
    //Setters

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public void setConductor(Conductor conductor) {
        this.conductor = conductor;
    }

    public void setCiudadDondeEsta(String ciudadDondeEsta) {
        this.ciudadDondeEsta = ciudadDondeEsta;
    }

    public void setKilometrosAutobus(int kilometrosAutobus) {
        this.kilometrosAutobus = kilometrosAutobus;
    }
    //Metodos añadidos
    public boolean asignarConductor(Conductor conductor, int kmViaje) {
        boolean sePuedeAsignar;

        //Si el conductor pasado como parámetro puede hacer el viaje
        if (conductor.puedeHacerKilometros(kmViaje))
        {
            //se asigna al atributo conductor y devuelve true
            this.conductor = conductor;
            sePuedeAsignar = true;
        }
        else
            sePuedeAsignar = false; // Si no puede hacer el viaje no hace nada y devuelve false.
        return sePuedeAsignar;
    }

    public void hacerViaje(int kmViaje, String ciudadDestino)
    {
        //añade los kilómetros al atributo Conductor y también suma a su atributo
        //kilometrosAutobus los kilómetros del viaje
        conductor.anyadeKilometros(kmViaje);
        kilometrosAutobus += kmViaje;

        //Luego modifica el atributo ciudadDondeEsta y le asigna la ciudad de destino
        ciudadDondeEsta = ciudadDestino;

        //Por último, cambia la ciudadAlojamiento del Conductor a la ciudad de destino.
        conductor.setCiudadAlojamiento(ciudadDestino);
    }

    public void liberarConductor()
    {
        conductor = null;
    }

    public void mostrarDatosAutobus()
    {
        System.out.println("MATRICULA: "+matricula);
        System.out.println("CIUDAD DONDE ESTA: "+ciudadDondeEsta);
        System.out.println("KILOMETROS DEL AUTOBUS: "+kilometrosAutobus);

        if ( conductor != null )
        {
            System.out.println("-----------------------------------------------");
            System.out.println(conductor.devolverDatosConductor());
        }
        System.out.println();
    }
}