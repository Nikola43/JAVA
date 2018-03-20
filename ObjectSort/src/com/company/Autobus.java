package com.company;

public class Autobus {
    //Atributos
    private String matricula;
    private String ciudadDondeEsta;
    private int kilometrosAutobus;

    //Constructores
    public Autobus()
    {
        matricula = "";
        ciudadDondeEsta = "";
        kilometrosAutobus = 0;
    }

    public Autobus(String matricula, String ciudadDondeEsta, int kilometrosAutobus)
    {
        this.matricula = matricula;
        this.ciudadDondeEsta = ciudadDondeEsta;
        this.kilometrosAutobus = kilometrosAutobus;
    }

    //Getters
    public String getMatricula() {
        return matricula;
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
    public void setKilometrosAutobus(int kilometrosAutobus) {
        this.kilometrosAutobus = kilometrosAutobus;
    }
    public void setCiudadDondeEsta(String ciudadDondeEsta) {
        this.ciudadDondeEsta = ciudadDondeEsta;
    }

    //Metodos añadidos
    public void mostrarDatosAutobus()
    {
        System.out.println("MATRICULA: "+matricula);
        System.out.println("CIUDAD DONDE ESTA: "+ciudadDondeEsta);
        System.out.println("KILOMETROS DEL AUTOBUS: "+kilometrosAutobus);
    }
}