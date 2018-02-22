package com.company;

public class Main
{
    public static void main(String[] ar)
    {
        int[] array = new int[10];

        cargar(array);
        imprimir(array);

        //ordenacionBurbuja(array);
        //ordenacionSeleccion(array);
        ordenacionInsercionDirecta(array);
        imprimir(array);
    }

    private static void cargar(int array[])
    {
        for (int i = 0; i < array.length; i++)
            array[i] = (int) (Math.random() * 100);
    }

    private static void ordenacionBurbuja(int array[])
    {
        for (int i = 0; i < array.length - 1; i++)
        {
            for (int j = array.length - 1; j > i; j--)
            {
                if (array[j] < array[j - 1])
                {
                    int aux = array[j];
                    array[j] = array[j - 1];
                    array[j - 1] = aux;
                }
            }
        }
    }

    private static void ordenacionSeleccion(int []array)
    {
        int minimo, numeroAuxiliar;

        for (int i = 0; i < array.length; i++)
        {
            minimo = i;
            for (int j = i + 1; j < array.length; j++)
                if (array[j] < array[minimo])
                    minimo = j;

            //Intercambiamos
            numeroAuxiliar = array[minimo];
            array[minimo] = array[i];
            array[i] = numeroAuxiliar;
        }
    }

    private static void ordenacionInsercionDirecta (int []array )
    {
        int numeroAuxiliar;

        for (int i=1; i<=9; i++)
        {
            numeroAuxiliar = array[i];

            for (int j=i-1; j>=0 && array[j]>numeroAuxiliar; j--)
            {
                array[j+1] = array[j];
                array[j] = numeroAuxiliar;
            }
        }
    }

    private static void imprimir(int []array)
    {
        for (int elemento: array)
            System.out.print(elemento+" ");

        System.out.println();
    }


}
