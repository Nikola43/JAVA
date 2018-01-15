import java.util.Random;

public class Main
{
    public static void main(String... args)
    {
        int [] vectorAleatorio = new int[10];

        rellenarVectorAleatoriamente(vectorAleatorio);

        System.out.println("Vector completo: ");
        imprimirVector(vectorAleatorio);

        System.out.println("Vector impares: ");
        imprimirImpares(vectorAleatorio);

        System.out.println("Vector pares: ");
        imprimirPares(vectorAleatorio);
    }

    private static void rellenarVectorAleatoriamente(int vector[]) {
        for ( int i = 0; i < vector.length; i++) vector[i] = randInt(1,20);
    }

    private static int randInt(int min, int max) {
        return new Random().nextInt((max - min) + 1) + min;
    }

    private static void imprimirVector(int vector[]) {
        for (int v: vector) System.out.print(v+" ");
        System.out.println();
    }

    private static void imprimirPares(int vector[]) {
        for (int v: vector) if (v % 2 == 0 ) System.out.print(v+" ");
        System.out.println();
    }

    private static void imprimirImpares(int vector[]) {
        for (int v: vector) if (v % 2 != 0 ) System.out.print(v+" ");
        System.out.println();
    }

    /*
1. Genera un vector de 10 posiciones vectorAleatorio que guarde valores aleatorios entre 1 y 20
        (pueden ser repetidos). Luego muestra por pantalla cuantos números pares y cuantos números
    impares hay en dicho vector (imprime el vector por pantalla también para comprobarlo).

2. Genera un vector vectorInicial de 10 posiciones, pide al usuario que introduzca números entre
1 y 20 en dicho vector hasta completarlo (pueden ser repetidos). Crea dos vectores vectorPares
    y vectorImpares que almacenen los valores pares e impares respectivamente del vector inicial.
    Luego muestra ambos vectores por pantalla.

3. Crea un vector vectorNumeros de 10 posiciones y guarda valores aleatorios (que pueden ser
        repetidos) en él entre 1 y 100. Debes mostrar por pantalla el valor máximo que hay
    almacenado en el vector y en qué posición está (muestra el vector por pantalla para poder
        comprobarlo).

4. Crea un vector numerosPositivos de 10 posiciones y pide al usuario que los rellene con valores
    entre 1 y 20. Muestra por pantalla la suma de los números pares que hay en el vector por un
    lado y la suma de los números impares que hay en el vector por otro.

5. Crea un vector numerosPositivos de 10 posiciones y pide al usuario que los rellene con valores
    entre 1 y 20. Muestra por pantalla la suma de los números que están en las posiciones pares
    por un lado y la suma de los números que están en las posiciones impares por otro.
    */


}
