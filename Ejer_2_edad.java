package Funciones_Edad_distanciaPrimo;

import ejer_1_Pseudocodigo_Java.Entrada;
import Ejercicios_Ampliacion_pseudocodigo.fecha_mayor;
import Practica_1.edad_altura_9;

public class Ejer_2_edad {
	static int DIAHOY = 4;
	static int MESHOY = 12;
	static int ANYOHOY = 2017;
	
	public static void main(String[] args)
	{
		int dia = 0, anyo = 0;
		String mes = new String(" ");

		
		
		System.out.println ("Introduzca un dia");
		dia = Entrada.entero();
		System.out.println("Mes en formato cadena");
		mes = Entrada.cadena().toLowerCase();
		System.out.println("Año en formato entero");
		anyo = Entrada.entero();
		
		if (fechaCorrecta(dia,pasaMesAEntero(mes), anyo))
		{
			calculaEdad(dia, pasaMesAEntero(mes), anyo);
		}
		else{
			System.out.println("La fecha introducida no es correcta");
		}
		
	}
	
	
	
	//funcion1 Booleano esBisiesto(Entero anyo) //devuelve cierto si el año es bisiesto y falso si el año no es bisiesto
	public static boolean esBisiesto(int anyo) {
	
		if ((anyo%4==0)&& ((anyo%100!=0 )||(anyo%400==0))){// ES BISIESTO
			return true;
		}
		return false;
	}
	
	
//funcion2 Entero diasMes(Entero mes, Entero anyo) //devuelve el número de días que tiene el mes
	//utilizo la funcion 1 en la funcion2 para saber si el año que le paso es bisiesto o no,DEpendiendo de eso mes 2 sera = a 28 0 29
	public static int diasMes(int mes, int anyo) {
		int diasDelMes = 0;
		
			switch (mes) 
			{
			//mes febrero
				case 2:
					if (esBisiesto(anyo)) 
						diasDelMes = 29;
					else
						diasDelMes = 28;
					break;
					
				//meses de 31 dias
				case 1:
				case 3:
				case 5:	
				case 7:
				case 8:	
				case 10:
				case 12:
					diasDelMes = 31;
					break;
			//dias de 30 dias		
				case 4:
				case 6:
				case 9:
				case 11:
					diasDelMes = 30;
					break;
			}
		
		return diasDelMes;
	}
	
//Entero pasaMesAEntero(Cadena mesCad) //devuelve el número del mes pasado a cadena, si la
	// cadena no se corresponde con ningún mes devuelve -1
	public static int pasaMesAEntero(String mesCad) {
		int mes = 0;
		
		switch (mesCad) {
		case "enero":   mes = 1; break;// otra forma de hacerlo
		case "febrero": mes = 2; break;
		case "marzo":
			mes = 3;
			break;
		case "abril":
			mes = 4;
			break;
		case "mayo":
			mes = 5;
			break;
		case "junio":
			mes = 6;
			break;
		case "julio":
			mes = 7;
			break;
		case "agosto":
			mes = 8;
			break;
		case "septiembre":
			mes = 9;
			break;
		case "octubre":
			mes = 10;
			break;
		case "noviembre":
			mes = 11;
			break;
		case "diciembre":
			mes = 12;
			break;
		default:
			mes = -1;
			break;
		}
		return mes;
		
	}
// funcion4 devuelve cierto si es correcta la fecha	
	public static boolean fechaCorrecta(int dia, int mes, int anyo) {
		
		boolean fechaValida = false;
		
		if(dia >= 1 && dia <= diasMes(mes,anyo ) && mes >=1 && mes <=12 && anyo <=2017)	
		{
			fechaValida = true;		
			}
			
		return fechaValida;
	}
	
	//funcion 5 devuelve cierto si la fecha (dia1,mes1,anyo1) es mayor que la fecha diaHoy,mesHoy,anyoHoy).
			public static boolean esMayor(int dia1, int mes1) {
				
				boolean menor = false;
				
				if (mes1 > MESHOY) 
				{
					//mes mayor
					menor = true;
				}
				else if (mes1 < MESHOY)
				{
					//mes menor
					menor = false;
				}
				else 
				{
					//mes igual
					if(dia1>DIAHOY)
					{
						//dia mayor
						menor = true;
					}
					else if (dia1<DIAHOY) 
					{
						// dia menor
						menor = false;
					}
					else
					{
						// dia iguales
						menor = false;
					}
				}
				
				return menor;
			}
			
// Funcion6 que muestra por pantalla la edad de la fecha dada	
	public static void calculaEdad(int dia, int mes, int anyo) {
		
		int edad = 0;
		
		if (esMayor(dia, mes)) {
			edad = ANYOHOY - anyo -1;
		}
		else {
			edad = ANYOHOY - anyo;
		}
		
		
		System.out.println("El usuario tiene:"+edad);
		
	}
}
		
	/*
	 * if(dia > = 1 && dia <= diasMes(mes,anyo ) && mes >=1 && mes <=12 && anyo <=2017)	
	 *///
//return = true
		
//if (dia > DIAHOY ){
//	diaActual = 30 + DIAHOY;
//	diaActual = diaActual - dia;
//	MESHOY -=1;
//}else{
//	diaActual = DIAHOY - dia;
//}
//
//if (mes > MESHOY){
//	mesActual = 12 + MESHOY;
//	mesActual = mesActual - mes;
//	anyoActual = ANYOHOY - 1;
//	anyoActual = anyoActual- anyo;
//	
//}else{
//	mesActual = MESHOY - mes;
//	anyoActual = ANYOHOY - anyo;
//	
//}		
//		
//		

//funcion4 devuelve cierto si es correcta la fecha	
//	public static boolean fechaCorrecta(int dia, int mes, int anyo) {
//		boolean fechaValida = false;
//		boolean bisiesto = false;
//		
//		bisiesto = esBisiesto(anyo);
//		
//		switch (mes) 
//		{
//		//mes febrero
//			case 2:
//				if (bisiesto && dia > 0 && dia <= 29) {
//					fechaValida = true;
//				}else if (!bisiesto && dia > 0 && dia <= 28) {
//					fechaValida = true;
//				}
//				break;
//				
//			//meses de 31 dias
//			case 1:
//			case 3:
//			case 5:	
//			case 7:
//			case 8:	
//			case 10:
//			case 12:
//				if (dia > 0 && dia <= 31){
//					fechaValida = true;
//				}
//				break;
//				
//		//dias de 30 dias		
//			case 4:
//			case 6:
//			case 9:
//			case 11:
//				if (dia > 0 && dia <=30){
//					fechaValida = true;
//				}
//				break;
//		
//		}
//		return fechaValida;
//	}