package TestClases;

import Clases.AvionPapel;
import Interfaces.IVolador;

public class TestAvionPapel
{
    public static void main(String []Args)
    {
        //Instanciamos tres aviones de papel
        AvionPapel avionPapelDefecto;
        AvionPapel avionPapelSobrecargado;
        AvionPapel avionPapelCopia;
        AvionPapel avionClon;

        //TEST CONSULTORES
        avionPapelDefecto      = new AvionPapel();
        avionPapelSobrecargado = new AvionPapel(4, 8, new IVolador() {
            @Override
            public void despegar() {
                System.out.println("Saliendo de sevilla");
            }

            @Override
            public void aterrizar() {
                System.out.println("Volviendo a sevilla");
            }
        });
        avionPapelCopia = new AvionPapel(avionPapelSobrecargado);

        //TEST METODOS CONSULTORES
        System.out.println("TEST METODOS CONSULTORES");
            //DEFECTO
            System.out.println("\tDEFECTO ");
            mostrarAtributosAvionPapel(avionPapelDefecto);

            //SOBRECARGADO
            System.out.println("\tSOBRECARGADO ");
            mostrarAtributosAvionPapel(avionPapelSobrecargado);

            //COPIA
            System.out.println("\tCOPIA ");
            mostrarAtributosAvionPapel(avionPapelCopia);

        //TEST METODOS MODIFICADORES
        System.out.println("TEST METODOS MODIFICADORES");
            //DEFECTO
            System.out.println("\tDEFECTO ");
            avionPapelDefecto.setAncho(6);
            avionPapelDefecto.setLargo(9);
            mostrarAtributosAvionPapel(avionPapelDefecto);

            //SOBRECARGADO
            System.out.println("\tSOBRECARGADO ");
            avionPapelSobrecargado.setAncho(10);
            avionPapelSobrecargado.setLargo(15);
            mostrarAtributosAvionPapel(avionPapelSobrecargado);

            //COPIA
            System.out.println("\tCOPIA ");
            avionPapelCopia.setAncho(6);
            avionPapelCopia.setLargo(9);
            mostrarAtributosAvionPapel(avionPapelCopia);

        //TEST METODOS SOBREESCRITOS
        System.out.println("TEST METODOS SOBRESCRITOS");
            //DEFECTO
            System.out.println("\tDEFECTO ");
            avionClon = avionPapelDefecto.clone();
            System.out.println("\ttoString:  "+avionPapelDefecto.toString());
            System.out.println("\tcompareTo: "+avionPapelDefecto.compareTo(avionPapelSobrecargado));
            System.out.println("\tequals:    "+avionPapelDefecto.equals(avionPapelSobrecargado));
            System.out.println("\thashCode:  "+avionPapelDefecto.hashCode());
            System.out.println("\tclone:     "+avionClon.toString()+"\n");

            //SOBRECARGADO
            System.out.println("\tSOBRECARGADO ");
            avionClon = avionPapelSobrecargado.clone();
            System.out.println("\ttoString:  "+avionPapelSobrecargado.toString());
            System.out.println("\tcompareTo: "+avionPapelSobrecargado.compareTo(avionPapelCopia));
            System.out.println("\tequals:    "+avionPapelSobrecargado.equals(avionPapelCopia));
            System.out.println("\thashCode:  "+avionPapelSobrecargado.hashCode());
            System.out.println("\tclone:     "+avionClon.toString()+"\n");

            //COPIA
            System.out.println("\tCOPIA ");
            avionClon = avionPapelCopia.clone();
            System.out.println("\ttoString:  "+avionPapelCopia.toString());
            System.out.println("\tcompareTo: "+avionPapelCopia.compareTo(avionPapelDefecto));
            System.out.println("\tequals:    "+avionPapelCopia.equals(avionPapelDefecto));
            System.out.println("\thashCode:  "+avionPapelCopia.hashCode());
            System.out.println("\tclone:     "+avionClon.toString()+"\n");

        //TEST METODOS SOBREESCRITOS DE LA INTERFAZ IVolador
        System.out.println("TEST METODOS SOBREESCRITOS DE LA INTERFAZ IVolador");
        System.out.print("\t despegar: ");
        avionPapelSobrecargado.getVolador().despegar();

        System.out.print("\t aterrizar: ");
        avionPapelSobrecargado.getVolador().aterrizar();
    }

    public static void mostrarAtributosAvionPapel(AvionPapel avionPapel)
    {
        System.out.println("\tAncho: "+avionPapel.getAncho());
        System.out.println("\tLargo: "+avionPapel.getLargo()+"\n");
    }
}
