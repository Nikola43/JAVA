package practica7JAVA;

class Conductor {
    //Atributos
    private String dni, nombre, apellidos, ciudadAlojamiento;
    private int kmMes;

    private final static int MAX_KILOMETROS_MES = 350;

    //Constructor sobrecargado
    public Conductor(String dni, String nombre, String apellidos, String ciudadAlojamiento)
    {
        this.dni = dni;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.ciudadAlojamiento = ciudadAlojamiento;
        this.kmMes = 0;
    }
    //Metodos consultores
    public String getDni() {
        return dni;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getCiudadAlojamiento() {
        return ciudadAlojamiento;
    }

    public int getKmMes() {
        return kmMes;
    }
    //Metodos modificadores

    public void setDni(String dni) {
        this.dni = dni;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public void setCiudadAlojamiento(String ciudadAlojamiento) {
        this.ciudadAlojamiento = ciudadAlojamiento;
    }

    public void setKmMes(int kmMes) {
        this.kmMes = kmMes;
    }

    //Metodos añadidos
    public boolean puedeHacerKilometros(int numeroKilometros)
    {
        return !((kmMes + numeroKilometros) > MAX_KILOMETROS_MES);
    }

    public void anyadeKilometros(int numKilometros)
    {
        kmMes += numKilometros;
    }
    public void reiniciaKmMes()
    {
        kmMes = 0;
    }
    public String devolverDatosConductor()
    {
        return  "NOMBRE: "+nombre+"\n"+
                "APELLIDOS: "+apellidos+"\n"+
                "DNI: "+dni+"\n"+
                "KILOMETROS REALIZADOS ESTE MES: "+kmMes+"\n"+
                "CIUDAD ALOJAMIENTO: "+ciudadAlojamiento+"\n";
    }
}