package practica7JAVA;

public class EstacionAutobuses {
    //Atributos
    private String nombreCiudad;
    private Autobus []andenes;
    private int autobusesEnAnden;

    //Constructores
    EstacionAutobuses()
    {
        nombreCiudad = "CORDOBA";
        andenes = new Autobus[6];
        autobusesEnAnden = 0;
    }

    EstacionAutobuses(String nomCiudad, int numAndenes)
    {
        nombreCiudad = nomCiudad;
        andenes = new Autobus[numAndenes];
        autobusesEnAnden = 0;
    }

    public String getNombreCiudad() {
        return nombreCiudad;
    }

    public Autobus[] getAndenes() {
        return andenes;
    }

    public int getAutobusesEnAnden() {
        return autobusesEnAnden;
    }

    public Autobus getAutobus(int pos) {
        //Comprobamos que la posicion es menor o igual que el numero de andenes
        //y que en esa posicion haya un autobus
        //Si no lo hay devolvemos null
        return ((pos <= andenes.length) && (andenes[pos] != null)) ? andenes[pos] : null;
    }

    public boolean hayAndenVacio()
    {
        for (int i = 0; i < andenes.length; i++)
            if (andenes[i] == null)
                return true;

        return false;
    }

    public int devuelvePosicionAutobusLibre()
    {
        for (int i = 0; i < andenes.length; i++)
            if ( andenes[i] != null )
                return i;

        return -1;
    }

    private int devuelvePosicionAndenVacio()
    {
        for (int i = 0; i < andenes.length; i++)
            if ( andenes[i] == null )
                return i;

        return -1;
    }

    public void introduceBusEnAndenVacio(Autobus autobus)
    {

        //Si hay un andén vacío
        if (hayAndenVacio())
        {
            //mete el autobús en esa posición del vector andenes
            andenes[devuelvePosicionAndenVacio()] = autobus;

            //libera al conductor de dicho autobús
            autobus.liberarConductor();

            //También aumenta el atributo autobusesEnAnden en 1
            autobusesEnAnden++;

        }
    }

    public Autobus sacarAutobusDelAnden(int pos)
    {
        Autobus autobus = null;

        //Si la posición está dentro del rango del vector andenes y hay un autobús en esa posición
        if ((pos <= andenes.length) && (andenes[pos] != null))
        {
            //guardamos el autobus
            autobus = andenes[pos];

            //deja vacía esa posición del vector andenes
            andenes[pos] = null;

            //disminuye en 1 el atributo autobusesEnAnden
            autobusesEnAnden--;
        }
        return autobus;
    }

    public void mostrarAutobuses()
    {
        System.out.println("------------------- ESTACION DE "+nombreCiudad+" -------------------");

        for (int i = 0; i < autobusesEnAnden; i++) {
            getAutobus(i).mostrarDatosAutobus();
        }

        System.out.println("Andenes ocupados: "+autobusesEnAnden);
        System.out.println("Andenes libre: "+(andenes.length - autobusesEnAnden));

        System.out.println("--------------------------------------------------------------------\n\n");
    }
}
