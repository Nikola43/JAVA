package EXAMEN23FEB2018;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class MicroTeatro
{
    final static int TAMCADENA = 8;
    final static int OBRAS = 4;
    final static int HORARIOS = 3;

    public static void main(String []Args) throws IOException
    {
        //Objeto para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        int [][]localidades = new int[OBRAS][HORARIOS];
        String []horarios = {"20:00", "21:30", "23:00"};
        String []obras;
        char opcionUsuario;
        String horarioOrdenar;
        String obraComprar;
        String horaComprar;
        int numeroEntradasComprar;
        String nombreUsuario;

        //Mostramos mensaje de administrador
        System.out.println("ROL ADMINISTRADOR: administrando sesiones");

        //Rellenamos matriz localidades
        iniciarSesiones(localidades);

        //rellenar las obras pidiendolo por consola
        obras = rellenarObras();

        //Muestra la tabla de localidades creada
        muestraObrasHorariosLocalidades(obras, horarios, localidades);

        //Mostramos mensaje de usuario
        System.out.println("ROL USUARIO: acceso al usuario");
        System.out.println("Bienvenido al microteatro");

        nombreUsuario = registrarse();

        do
        {
            //Pedimos datos de registro al usuario
            System.out.println("Eres el usuario: "+nombreUsuario);

            mostrarMenuUsuario();
            opcionUsuario = bufferedReader.readLine().charAt(0);

            switch (opcionUsuario)
            {
                case 'a':
                    ordenaPorObras(obras, localidades);
                    muestraObrasHorariosLocalidades(obras, horarios, localidades);
                    break;

                case 'b':
                    System.out.println("Introduce la hora por la que quieres ordenar: ");
                    horarioOrdenar = bufferedReader.readLine();
                    ordenarPorObraConMasEntradasEnHorario(obras, localidades, horarios, horarioOrdenar);
                    muestraObrasHorariosLocalidades(obras, horarios, localidades);
                    break;

                case 'c':
                    System.out.println("Introduce el nombre de la obra: ");
                    obraComprar = bufferedReader.readLine();

                    System.out.println("Introduce la hora: ");
                    horaComprar = bufferedReader.readLine();

                    System.out.println("Introduce el numero de entradas: ");
                    numeroEntradasComprar = Integer.parseInt(bufferedReader.readLine());

                    if (compraEntrada(obras, obraComprar, horarios, horaComprar, localidades, numeroEntradasComprar))
                        System.out.println("¡Compra realizada!");
                    else
                        System.out.println("No se pudo realizar la compra");

                    break;
                case 's': break;
                default:
                    System.out.println("No ha seleccionado una opcion valida");
            }
        }while (opcionUsuario != 's');
    }

    public static void mostrarMenuUsuario()
    {
        System.out.println("a. Ver sesiones por orden alfabetico");
        System.out.println("b. Ver sesiones con mayor numero de entradas en una sesion");
        System.out.println("c. Comprar entradas");
        System.out.println("s. Salir");
    }

    public static String registrarse() throws IOException {

        String nombreUsuario = "";

        //Objeto para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        //Variables donde almacenamos la informacion del usuario
        String nombre, apellidos, DNI;
        String nombreDividido[], apellidosDivididos[];

        //leemos por teclado
        System.out.print("Introduzca su nombre: ");   nombre = bufferedReader.readLine();
        System.out.print("Introduzca su apellido: "); apellidos = bufferedReader.readLine();
        System.out.print("Introduzca su DNI: ");      DNI = bufferedReader.readLine();

        //Separamos el nombre por espacios
        nombreDividido = nombre.split(" ");

        //extraemos su inicial
        nombreUsuario += Character.toUpperCase(nombreDividido[0].charAt(0));
        if (nombreDividido.length > 1) //Si es nombre compuesto
            nombreUsuario += Character.toUpperCase(nombreDividido[1].charAt(0));

        //Separamos el apellido por espacios
        apellidosDivididos = apellidos.split(" ");

        //extraemos su inicial
        nombreUsuario += Character.toUpperCase(apellidosDivididos[0].charAt(0));
        if (apellidosDivididos.length > 1) //Si tiene 2 apellidos
            nombreUsuario += Character.toUpperCase(apellidosDivididos[1].charAt(0));

        //Extraemos los ultimos 3 numeros del dni
        nombreUsuario += DNI.charAt(DNI.length()-4);
        nombreUsuario += DNI.charAt(DNI.length()-3);
        nombreUsuario += DNI.charAt(DNI.length()-2);

        return nombreUsuario;
    }

    public static void iniciarSesiones(int [][]sesiones)
    {
        for (int i = 0; i < sesiones.length; i++)
            for (int j = 0; j < sesiones[i].length; j++)
                sesiones[i][j] = 5;
    }

    public static String[] rellenarObras() throws IOException {
        String []obrasOfertadas = new String[OBRAS];
        String obraActual;
        String obraAuxiliar = "";


        //Objeto para leer por teclado
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        for (int i = 0; i < obrasOfertadas.length; i++) {

            System.out.print("Introduzca el nombre de la obra: ");
            obraActual = bufferedReader.readLine();


            if (obraActual.length() > TAMCADENA) //Si la plabra es mayor
            {
                for (int j = 0; j < TAMCADENA; j++) {
                    obraAuxiliar += obraActual.charAt(j);
                }
                obrasOfertadas[i] = obraAuxiliar;
            }
            else if (obraActual.length() < TAMCADENA) //Si la plabra es menor
            {
                for (int k = obraActual.length(); k < TAMCADENA; k++) {
                    obraActual += " ";
                }
                obrasOfertadas[i] = obraActual;
            }
            obraActual = "";
            obraAuxiliar = "";
        }
        return obrasOfertadas;
    }

    public static void muestraObrasHorariosLocalidades(String []obras, String []horarios, int [][]localidades)
    {
        System.out.print("\t\t   ");
        for (int i = 0; i < horarios.length; i++) {
            System.out.print("\t"+horarios[i]+" ");
        }
        System.out.println();
        for (int i = 0; i < localidades.length; i++)
        {
            System.out.print(obras[i]);

            for (int j = 0; j < localidades[i].length; j++)
            {
                System.out.print("\t\t"+localidades[i][j]+" ");
            }
            System.out.println();
        }
    }

    public static int devuelvePosicionRecursiva(String []cadenas, String cadena, int posicion)
    {
        int devuelto =  -1;

        //Si encuentra la cadena devuelve la posicion
        if( cadenas[posicion].equals(cadena)) {
            devuelto = posicion;
        }
        else {
            if (posicion > 1)
                devuelto = devuelvePosicionRecursiva(cadenas, cadena, posicion - 1);
        }

        return devuelto;
    }

    public static void ordenaPorObras(String []obras, int [][]localidades)
    {
        String obraAuxiliar;
        int localidadAxiliar;

        for (int i = 0; i < obras.length -1; i++)
        {
            for (int j = obras.length -1; j > i; j--)
            {
                if (obras[j].compareTo(obras[j-1]) < 0)
                {
                    //Cambiamos de posicion las obras
                    obraAuxiliar = obras[j];
                    obras[j] = obras [j-1];
                    obras[j-1] = obraAuxiliar;

                    //Cambiamos de posicion las localidades
                    localidadAxiliar = localidades[i][j];
                    localidades[i][j] = localidades[i][j-1];
                    localidades[i][j-1] = localidadAxiliar;
                }
            }
        }
    }

    //Se me ha atascado un poco esta funcion y la de comprar, tengo el cerebro embotado
    //Creo que ya no voy a ningun lado, esperaba que me saliera mejor, pero estoy mas o menos contento con el resultado
    public static void ordenarPorObraConMasEntradasEnHorario(String []obras, int [][]localidades, String []horarios, String horarioOrdenar)
    {
        String obraAuxiliar;
        int localidadAxiliar;

        for (int i = 0; i < horarios.length -1; i++)
        {
            for (int j = horarios.length -1; j > i; j--)
            {
                if (horarios[j].compareTo(horarioOrdenar) < 0)
                {
                    //Cambiamos de posicion las localidades
                    localidadAxiliar = localidades[i][j];
                    localidades[i][j] = localidades[i][j-1];
                    localidades[i][j-1] = localidadAxiliar;

                    //Cambiamos de posicion las obras
                    obraAuxiliar = obras[j];
                    obras[j] = obras [j-1];
                    obras[j-1] = obraAuxiliar;
                }
            }
        }
    }

    public static boolean compraEntrada(String []obras, String obraComprar, String []horarios, String horarioCompra, int[][]localidades, int numeroEntradas)
    {
        boolean sePuedeComprar = true;

        //Comprobamos que la obra existe
        for (int i = 0; i < obras.length && sePuedeComprar; i++) {
            sePuedeComprar = obras[i].equals(obraComprar);
        }

        //Comprobamos que el horario existe
        for (int i = 0; i < horarios.length && sePuedeComprar; i++) {
            sePuedeComprar = horarios[i].equals(horarioCompra);
        }

        int pos = devuelvePosicionRecursiva(obras, obraComprar, obras.length);

        return sePuedeComprar;
    }
}
