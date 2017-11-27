public class Main
{
    public static void main(String[] args) {
        // TODO Auto-generated method stub

        int numCarta=0, contadorIntentos=3, numAleatorio=0, numPalo = 0, paloAleatorio;
        String palo = "";

        System.out.println("Empieza el juego. GENERANDO CARTA");

        //generamos el numero y el palo aleatorios
        numAleatorio=(int)Math.round((Math.random()*(12-1)+1));
        paloAleatorio=(int)Math.round((Math.random()*(4-1)+1));

        //el contador de intentos va a ir decrementando hasta llegar a 0 intentos
        while (contadorIntentos>0){

            //pedimos al usuario numero y palo
            System.out.println("Introduce el numero de la carta");
            numCarta=Entrada.entero();

            System.out.println("Introduce el palo");
            palo=Entrada.cadena();

            //asignamos a cada palo un numero ya que lo que se genera aleatoriamente es un numero
            switch (palo) {
                case "oros":
                    numPalo=1;
                    break;

                case "copas":
                    numPalo=2;
                    break;

                case "bastos":
                    numPalo=3;
                    break;

                case "espadas":
                    numPalo=4;
                    break;
            }

            System.out.println(numPalo);
            System.out.println(numAleatorio);


            //comprobamos si el numero y el palo dado por el usuario es correcto, si no disminuye el numero de intentos
            if (numCarta!=numAleatorio || numPalo!=paloAleatorio){
                contadorIntentos--;
                System.out.println("Fallaste te quedan "+contadorIntentos+" intentos");
                if (contadorIntentos==0){
                    System.out.println("La carta era el "+numAleatorio+ " de "+palo );
                }
            }

            //si el usuario acierta igualamos el contador de intentos a 0 para que no vuelva a pedirnos un numero y el palo
            else if (numCarta==numAleatorio && numPalo==paloAleatorio) {
                contadorIntentos=0;
                System.out.println("MUY BIEN. ACERTASTE");
            }
        }

    }
}

