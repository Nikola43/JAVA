package com.company;

public class Main {

    public static void main(String[] args) {

        //Creamos un vector de autobuses
        com.company.Autobus[]autobuses = new com.company.Autobus[5];

        //Insertamos 5 autobuses
        autobuses[0] = new com.company.Autobus("SR-12245", "Sevilla", 325);
        autobuses[1] = new com.company.Autobus("SR-14375", "Malaga", 254);
        autobuses[2] = new com.company.Autobus("SR-13685", "Huelva", 224);
        autobuses[3] = new com.company.Autobus("SR-11136", "Jaen", 315);
        autobuses[4] = new com.company.Autobus("SR-11269", "Cordoba", 145);

        //Mostramos los datos de los autobuses desordenados
        System.out.println("AUTOBUSES SIN ORDENDAS");
        mostrarDatosAutobuses(autobuses);

        //Ordenamos por ciudad donde esta el bus
        System.out.println("ORDENAMOS");
        //ordenacionInsercionCiudadDondeEsta(autobuses);
        //ordenacionInsercionKilometrosAutobus(autobuses);
        //ordenacionInsercionMatricula(autobuses);

        //ordenacionSeleccionKilometrosAutobus(autobuses);
        //ordenacionSeleccionCiudadDondeEsta(autobuses);
        ordenacionSeleccionMatricula(autobuses);

        //Mostramos despues de ordenar
        System.out.println("MOSTRAMOS DESPUES DE ORDENAR");
        mostrarDatosAutobuses(autobuses);


    }

    private static void mostrarDatosAutobuses(com.company.Autobus[]autobuses)
    {
        int counter = 0;
        for (com.company.Autobus autobusActual: autobuses) {
            counter++;
            System.out.println(counter);
            autobusActual.mostrarDatosAutobus();
            System.out.println();
        }
    }

    private static void ordenacionInsercionKilometrosAutobus (com.company.Autobus[]autobuses)
    {
        com.company.Autobus autobusAuxiliar;

        for (int i = 1; i < autobuses.length; i++)
        {
            autobusAuxiliar = autobuses[i];

            for (int j = i - 1; j >= 0 && autobuses[j].getKilometrosAutobus() > autobusAuxiliar.getKilometrosAutobus(); j--)
            {
                autobuses[j+1] = autobuses[j];
                autobuses[j] = autobusAuxiliar;
            }
        }
    }

    private static void ordenacionInsercionCiudadDondeEsta(com.company.Autobus[]autobuses)
    {
        com.company.Autobus autobusAuxiliar;

        for (int i = 1; i < autobuses.length; i++)
        {
            autobusAuxiliar = autobuses[i];

            for (int j = i - 1; j >= 0 && autobuses[j].getCiudadDondeEsta().compareTo(autobusAuxiliar.getCiudadDondeEsta()) > 0; j--)
            {
                autobuses[j+1] = autobuses[j];
                autobuses[j] = autobusAuxiliar;
            }
        }
    }

    private static void ordenacionInsercionMatricula(com.company.Autobus[]autobuses)
    {
        com.company.Autobus autobusAuxiliar;

        for (int i = 1; i < autobuses.length; i++)
        {
            autobusAuxiliar = autobuses[i];

            for (int j = i - 1; j >= 0 && autobuses[j].getMatricula().compareTo(autobusAuxiliar.getMatricula()) > 0; j--)
            {
                autobuses[j+1] = autobuses[j];
                autobuses[j] = autobusAuxiliar;
            }
        }
    }

    private static void ordenacionSeleccionKilometrosAutobus(com.company.Autobus[]autobuses)
    {
        int minimo;
        com.company.Autobus autobusAuxiliar;

        for (int i = 0; i < autobuses.length; i++)
        {
            minimo = i;
            for (int j = i + 1; j < autobuses.length; j++)
                if (autobuses[j].getKilometrosAutobus() < autobuses[minimo].getKilometrosAutobus())
                    minimo = j;

            //Intercambiamos
            autobusAuxiliar = autobuses[minimo];
            autobuses[minimo] = autobuses[i];
            autobuses[i] = autobusAuxiliar;
        }
    }

    private static void ordenacionSeleccionMatricula(com.company.Autobus[]autobuses)
    {
        int minimo;
        com.company.Autobus autobusAuxiliar;

        for (int i = 0; i < autobuses.length; i++)
        {
            minimo = i;
            for (int j = i + 1; j < autobuses.length; j++)
                if (autobuses[j].getMatricula().compareTo(autobuses[minimo].getMatricula()) < 0)
                    minimo = j;

            //Intercambiamos
            autobusAuxiliar = autobuses[minimo];
            autobuses[minimo] = autobuses[i];
            autobuses[i] = autobusAuxiliar;
        }
    }

    private static void ordenacionSeleccionCiudadDondeEsta(com.company.Autobus[]autobuses)
    {
        int minimo;
        com.company.Autobus autobusAuxiliar;

        for (int i = 0; i < autobuses.length; i++)
        {
            minimo = i;
            for (int j = i + 1; j < autobuses.length; j++)
                if (autobuses[j].getCiudadDondeEsta().compareTo(autobuses[minimo].getCiudadDondeEsta()) < 0)
                    minimo = j;

            //Intercambiamos
            autobusAuxiliar = autobuses[minimo];
            autobuses[minimo] = autobuses[i];
            autobuses[i] = autobusAuxiliar;
        }
    }
}
