

public class AvionPapel implements Cloneable, Comparable<AvionPapel>, IVolador
{
    //ATRIBUTOS
    private int ancho;
    private int largo;

    //CONSTRUCTORES
    //CONTRUCTOR POR DEFECTO
    public AvionPapel(AvionPapel avionPapel) {
        ancho = 0;
        largo = 0;
    }

    //CONSTRUCTOR SOBRECARGADO
    public AvionPapel(int ancho, int largo) {
        this.ancho = ancho;
        this.largo = largo;
    }

    //CONSTRUCTOR DE COPIA
    public AvionPapel(AvionPapel2 avionPapel ) {
        this.ancho = avionPapel.getAncho();
        this.largo = avionPapel.getLargo();
    }

    //METODOS CONSULTORES
    public int getAncho() {
        return ancho;
    }

    public int getLargo() {
        return largo;
    }

    //METODOS MODIFICADORES
    public void setAncho(int ancho) {
        this.ancho = ancho;
    }

    public void setLargo(int largo) {
        this.largo = largo;
    }

    //METODOS SOBRESCRITOS
    @Override
    public String toString()
    {
        String texto;
        texto = this.getAncho()+","+this.getLargo();
        return texto;
    }

    @Override
    public int hashCode()
    {
        int code;
        code = this.getAncho() * 13 / 2 % this.getLargo() * 7 + 6;
        return code;
    }

    @Override
    public AvionPapel2 clone()
    {
        AvionPapel2 clonAvionPapel2 = null;

        try
        {
            clonAvionPapel2 = (AvionPapel2) super.clone();
        }
        catch (CloneNotSupportedException e)
        {
            e.printStackTrace();
        }
        return clonAvionPapel2;
    }

    /*
    CABECERA        -> public int compareTo(AvionPapel2 avionPapel2)
    DESCRIPCION     -> Compara el avion que lanza el metodo con el avion pasado por parametro
                       según la suma de sus dimensiones
    ENTRADAS        -> Un objeto del tipo AvionPapel2
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
            if ( ((this.getAncho() + this.getLargo()) < (avionPapel.getAncho() + avionPapel.getLargo())) ) {
                resultadoComparacion = -1; //Menor
            }
            else if ( ((this.getAncho() + this.getLargo()) > (avionPapel.getAncho() + avionPapel.getLargo())) ) {
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

        if (object != null && object instanceof AvionPapel2)
        {
            AvionPapel2 avionPapel2 = (AvionPapel2) object;

            if ( (this.getAncho() == avionPapel2.getAncho()) && (this.getLargo() == avionPapel2.getLargo()) )
                esIgual = true;
        }
        return esIgual;
    }

    //METODOS SOBRESCRITOS DE LA INTERFAZ IVOLADOR
    @Override
    public void despegar() {
        System.out.println("Saliendo de sevilla");
    }

    @Override
    public void aterrizar() {
        System.out.println("Volviendo a sevilla");
    }
}
