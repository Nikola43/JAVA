import java.util.Random;

public class Main 
{
    public static void main(String... Args)
    {
		System.out.println("DESORDENADA");
		String matrizPalabras[] = {"perro","calle","ruido","perdiz"};
		imprimeVector(matrizPalabras);
		
		System.out.println("ORDENADA\n\n");
		
		String matrizPalabrass[] = ordenarVectorRecursivamente(matrizPalabras, matrizPalabras.length);
		
		imprimeVector(matrizPalabrass);
		
    }
    
    public static void imprimeVector(String []v)
    {
		for (int i = 0; i < v.length; i++)
		{
			System.out.println(v[i]+" ");
		}
	}
	
	public static String[] ordenarVectorRecursivamente(String []v, int palabrasRestantes)
	{
		String menor;
		
		String anterior;
		String actual;
		int contadorPalabras = 1;
		String aux;
		
		anterior = v[contadorPalabras-1];
		actual = v[contadorPalabras];
	
		if ( actual.compareTo(anterior) < 0 )
		{
			aux = v[contadorPalabras];
			v[contadorPalabras] = v[contadorPalabras - 1];
			v[contadorPalabras - 1] = aux;
		}
		
		if (palabrasRestantes > 1)
			ordenarVectorRecursivamente(v, palabrasRestantes - 1);
			
			contadorPalabras++;
			
		return v;	
	}
}
