package Clases;

import Interfaces.IVolador;

public class AvionPapel implements Cloneable, Comparable<AvionPapel>
{
    //ATRIBUTOS
    private int ancho;
    private int largo;
    private IVolador volador;

    //CONSTRUCTORES
    //CONTRUCTOR POR DEFECTO
    public AvionPapel () {
        ancho = 0;
        largo = 0;
        volador = null;
    }

    //CONSTRUCTOR SOBRECARGADO
    public AvionPapel(int ancho, int largo, IVolador volador) {
        this.ancho = ancho;
        this.largo = largo;
        this.volador = volador;
    }

    //CONSTRUCTOR DE COPIA
    public AvionPapel( AvionPapel avionPapel ) {
        this.ancho = avionPapel.getAncho();
        this.largo = avionPapel.getLargo();
        this.volador = avionPapel.getVolador();
    }

    //METODOS CONSULTORES
    public int getAncho() {
        return ancho;
    }

    public int getLargo() {
        return largo;
    }

    public IVolador getVolador() {
        return volador;
    }

    //METODOS MODIFICADORES
    public void setAncho(int ancho) {
        this.ancho = ancho;
    }

    public void setLargo(int largo) {
        this.largo = largo;
    }

    public void setVolador(IVolador volador) {
        this.volador = volador;
    }

    //METODOS SOBRESCRITOS
    @Override
    public String toString()
    {
        String texto;
        texto = getAncho()+","+getLargo();
        return texto;
    }

    @Override
    public int hashCode()
    {
        int code;
        code = getAncho() * 13 / 2 % getLargo() * 7 + 6;
        return code;
    }

    @Override
    public AvionPapel clone()
    {
        AvionPapel clonAvionPapel = null;

        try
        {
            clonAvionPapel = (AvionPapel) super.clone();
        }
        catch (CloneNotSupportedException e)
        {
            e.printStackTrace();
        }
        return clonAvionPapel;
    }

    /*
    CABECERA        -> public int compareTo(AvionPapel avionPapel)
    DESCRIPCION     -> Compara el avion que lanza el metodo con el avion pasado por parametro
                       según la suma de sus dimensiones
    ENTRADAS        -> Un objeto del tipo AvionPapel
    PRECONDICIONES  -> -
    SALIDAS         -> Un entero
    POSTCONDICIONES -> Devolverá -1 cuando sea mas pequeño que el avion pasado por parámetro
                    -> Devolverá  0 cuando sea    igual    que el avion pasado por parámetro
                    -> Devolverá  1 cuando sea mas grande  que el avion pasado por parámetro
    */
    @Override
    public int compareTo(AvionPapel avionPapel)
    {
        int resultadoComparacion = 0;

        if ( avionPapel != null )
        {
            if ( ((getAncho() + getLargo()) < (avionPapel.getAncho() + avionPapel.getLargo())) ) {
                resultadoComparacion = -1; //Menor
            }
            else if ( ((getAncho() + getLargo()) > (avionPapel.getAncho() + avionPapel.getLargo())) ) {
                resultadoComparacion = 1; //Mayor
            }
        }
        return resultadoComparacion;
    }

    /*
    CABECERA        -> public boolean equals(Object object)
    DESCRIPCION     -> Comprueba si el objeto que lanza el metodo es igual que el objeto pasado por parametro
    ENTRADAS        -> Un objeto
    PRECONDICIONES  -> -
    SALIDAS         -> Un boolean
    POSTCONDICIONES -> Devolverá TRUE  (IGUALES)   cuando sean del mismo tipo y tengan tengan las mismas dimensiones
                    -> Devolverá FALSE (DISTINTOS) cuando sean del mismo tipo y al menos una de sus dimensiones no tengan el mismo valor
    */
    @Override
    public boolean equals(Object object)
    {
        boolean esIgual = false;

        if (object != null && object instanceof AvionPapel)
        {
            AvionPapel avionPapel = (AvionPapel) object;

            if ( (getAncho() == avionPapel.getAncho()) && (getLargo() == avionPapel.getLargo()) )
                esIgual = true;
        }
        return esIgual;
    }
}
