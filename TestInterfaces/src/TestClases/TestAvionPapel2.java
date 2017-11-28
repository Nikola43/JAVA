package TestClases;

import Clases.AvionPapel2;

public class TestAvionPapel2
{
    public static void main(String []Args)
    {
        //Instanciamos tres aviones de papel
        AvionPapel2 avionPapel2Defecto;
        AvionPapel2 avionPapel2Sobrecargado;
        AvionPapel2 avionPapel2Copia;
        AvionPapel2 avionPapel2Clon;

        //TEST CONSULTORES
        avionPapel2Defecto      = new AvionPapel2();
        avionPapel2Sobrecargado = new AvionPapel2(4, 8);
        avionPapel2Copia        = new AvionPapel2(avionPapel2Sobrecargado);

        //TEST METODOS CONSULTORES
        System.out.println("TEST METODOS CONSULTORES");
        //DEFECTO
        System.out.println("\tDEFECTO ");
        mostrarAtributosAvionPapel2(avionPapel2Defecto);

        //SOBRECARGADO
        System.out.println("\tSOBRECARGADO ");
        mostrarAtributosAvionPapel2(avionPapel2Sobrecargado);

        //COPIA
        System.out.println("\tCOPIA ");
        mostrarAtributosAvionPapel2(avionPapel2Copia);

        //TEST METODOS MODIFICADORES
        System.out.println("TEST METODOS MODIFICADORES");
        //DEFECTO
        System.out.println("\tDEFECTO ");
        avionPapel2Defecto.setAncho(6);
        avionPapel2Defecto.setLargo(9);
        mostrarAtributosAvionPapel2(avionPapel2Defecto);

        //SOBRECARGADO
        System.out.println("\tSOBRECARGADO ");
        avionPapel2Sobrecargado.setAncho(10);
        avionPapel2Sobrecargado.setLargo(15);
        mostrarAtributosAvionPapel2(avionPapel2Sobrecargado);

        //COPIA
        System.out.println("\tCOPIA ");
        avionPapel2Copia.setAncho(6);
        avionPapel2Copia.setLargo(9);
        mostrarAtributosAvionPapel2(avionPapel2Copia);

        //TEST METODOS SOBREESCRITOS
        System.out.println("TEST METODOS SOBRESCRITOS");
        //DEFECTO
        System.out.println("\tDEFECTO ");
        avionPapel2Clon = avionPapel2Defecto.clone();
        System.out.println("\ttoString:  "+avionPapel2Defecto.toString());
        System.out.println("\tcompareTo: "+avionPapel2Defecto.compareTo(avionPapel2Sobrecargado));
        System.out.println("\tequals:    "+avionPapel2Defecto.equals(avionPapel2Sobrecargado));
        System.out.println("\thashCode:  "+avionPapel2Defecto.hashCode());
        System.out.println("\tclone:     "+avionPapel2Clon.toString()+"\n");

        //SOBRECARGADO
        System.out.println("\tSOBRECARGADO ");
        avionPapel2Clon = avionPapel2Sobrecargado.clone();
        System.out.println("\ttoString:  "+avionPapel2Sobrecargado.toString());
        System.out.println("\tcompareTo: "+avionPapel2Sobrecargado.compareTo(avionPapel2Copia));
        System.out.println("\tequals:    "+avionPapel2Sobrecargado.equals(avionPapel2Copia));
        System.out.println("\thashCode:  "+avionPapel2Sobrecargado.hashCode());
        System.out.println("\tclone:     "+avionPapel2Clon.toString()+"\n");

        //COPIA
        System.out.println("\tCOPIA ");
        avionPapel2Clon = avionPapel2Copia.clone();
        System.out.println("\ttoString:  "+avionPapel2Copia.toString());
        System.out.println("\tcompareTo: "+avionPapel2Copia.compareTo(avionPapel2Defecto));
        System.out.println("\tequals:    "+avionPapel2Copia.equals(avionPapel2Defecto));
        System.out.println("\thashCode:  "+avionPapel2Copia.hashCode());
        System.out.println("\tclone:     "+avionPapel2Clon.toString()+"\n");

        //TEST METODOS SOBREESCRITOS DE LA INTERFAZ IVolador
        System.out.println("TEST METODOS SOBREESCRITOS DE LA INTERFAZ IVolador");
        System.out.print("\t despegar: ");
        avionPapel2Sobrecargado.despegar();

        System.out.print("\t aterrizar: ");
        avionPapel2Sobrecargado.aterrizar();
    }

    public static void mostrarAtributosAvionPapel2(AvionPapel2 avionPapel2)
    {
        System.out.println("\tAncho: "+avionPapel2.getAncho());
        System.out.println("\tLargo: "+avionPapel2.getLargo()+"\n");
    }
}