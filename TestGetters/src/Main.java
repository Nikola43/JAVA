import java.util.ArrayList;

public class Main {
    public static void main(String []Args) {
        long inicioConGetter, finConGetter;
        long inicioSinGetter, finSinGetter;

        ArrayList<AvionPapel> listaAviones = new ArrayList<>();
        ArrayList<AvionPapel2> listaAviones2 = new ArrayList<>();

        AvionPapel2 avionPapel2;
        AvionPapel avionPapel;

        avionPapel2 = new AvionPapel2(4, 8); //SIN GETTERS
        avionPapel = new AvionPapel(4, 8);   //CON GETTERS


        //INICIO
        inicioConGetter = System.currentTimeMillis();
        for (int i = 0; i < 10000000; i++) {
            listaAviones.add(new AvionPapel(avionPapel));
        }
        finConGetter = System.currentTimeMillis();
        //FIN

        //INICIO
        inicioSinGetter = System.currentTimeMillis();
        for (int i = 0; i < 10000000; i++) {
            listaAviones2.add(new AvionPapel2(avionPapel2));
        }
        finSinGetter = System.currentTimeMillis();
        //FIN

        //CON GETTERS
        System.out.println("CON GETTERS");
        System.out.println("Inicio: "+inicioConGetter);
        System.out.println("Fin: "+finConGetter);
        System.out.println("Diferencia: "+(finConGetter - inicioConGetter));
        System.out.println();

        //SIN GETTERS
        System.out.println("SIN GETTERS");
        System.out.println("Inicio: "+inicioSinGetter);
        System.out.println("Fin: "+finSinGetter);
        System.out.println("Diferencia: "+(finSinGetter - inicioSinGetter));
    }
}
