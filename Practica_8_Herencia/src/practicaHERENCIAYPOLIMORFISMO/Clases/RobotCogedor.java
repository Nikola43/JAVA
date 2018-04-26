package practicaHERENCIAYPOLIMORFISMO.Clases;

import practicaHERENCIAYPOLIMORFISMO.Interfaces.ICogible;

public class RobotCogedor extends Robot implements ICogible {
    //Atributos
    private int brazoAlcanza;
    private Objeto[] objetos;
    private int numeroObjetos;

    //Constructores
    public RobotCogedor(int posY, int posX, int brazoAlcanza) {
        super(posY, posX);
        this.brazoAlcanza = brazoAlcanza;
        objetos = new Objeto[4];
        numeroObjetos = 0;
    }

    //Metodos heredados

    @Override
    public boolean coger(Objeto obj) {
        boolean resultado = false;
        int hueco = hayHuecoLibreVectorObjetos();

        //Si el objeto pasado por parametro no es nulo y hay hueco en el vector
        if (obj != null && hueco != -1) {
            // X +
            if (this.getPosX() + brazoAlcanza <= obj.getPosX()) {
                objetos[hueco] = obj;
                numeroObjetos++;
                resultado = true;
            }

            // X -
            if (this.getPosX() + brazoAlcanza >= obj.getPosX() && !resultado) {
                objetos[hueco] = obj;
                numeroObjetos++;
                resultado = true;
            }

            // Y +
            if (this.getPosY() + brazoAlcanza <= obj.getPosX() && !resultado) {
                objetos[hueco] = obj;
                numeroObjetos++;
                resultado = true;
            }

            // Y -
            if (this.getPosY() + brazoAlcanza >= obj.getPosX() && !resultado) {
                objetos[hueco] = obj;
                numeroObjetos++;
                resultado = true;
            }
        }
        return resultado;
    }

    @Override
    public boolean soltar(Objeto obj) {
        boolean resultado = false;
        int posicionObjeto = devolverPosicionObjeto(obj);

        if (posicionObjeto != -1) {
            objetos[posicionObjeto] = null;
            numeroObjetos--;
            resultado = true;
        }

        return resultado;
    }

    //Metodos añadidos
    /*
        Comentario: Me ha sido necesaria esta funcion para la funcion coger(Objeto obj)
                    creo que simplifica el codigo, la hace mas legible y aumenta la cohesion

        Prototipo: private int hayHuecoLibreVectorObjetos();
        Funcion: Devuelve la primera posicion libre que encuentra en el vector de objetos
        Entradas: -
        Precondiciones: -
        Salidas: Un entero
        Postcondiciones:
            -> Devolvera -1 cuando no haya ninguna posicion libre
            -> Devolvera un numero entre 0 y el tamaño maximo del vector de objetos
               que sera la posicion libre
     */
    private int hayHuecoLibreVectorObjetos() {

        for (int i = 0; i < objetos.length; i++)
            if (objetos[i] == null)
                return (i);

        return -1;
    }

    /*
        Comentario:

        Prototipo: public void reagruparObjetos(Objeto []objetos);
        Funcion: Reagrupa el vector de objetos dejando los nulos al final
        Entradas: Vector de objetos
        Precondiciones: -
        Salidas: -
        Postcondiciones: -
     */

    public void reagruparObjetos() {
        Objeto objetoAux;

        for (int i = 1; i < objetos.length; i++) {
            objetoAux = objetos[i];

            for (int j = i - 1; j >= 0 && objetos[j] == null; j--) {
                objetos[j + 1] = objetos[j];
                objetos[j] = objetoAux;
            }
        }
    }

    public void ordenarObjetosCogidosPorPeso() {
        if (numeroObjetos > 0) {
            //Primero reagrupamos
            reagruparObjetos();

            Objeto objetoAux;

            for (int i = 1; i < numeroObjetos; i++) {
                objetoAux = objetos[i];

                for (int j = i - 1; j >= 0 && objetos[j].getPeso() > objetoAux.getPeso(); j--) {
                    objetos[j + 1] = objetos[j];
                    objetos[j] = objetoAux;
                }
            }
        } else
            System.out.println("Este robot no tiene ningun objeto");
    }

    public void ordenarObjetosCogidosPorAreaYVolumen() {
        if (numeroObjetos > 0) {

            reagruparObjetos();
            Objeto objetoAux;

            for (int i = 1; i < objetos.length; i++) {
                objetoAux = objetos[i];

                for (int j = i - 1; j >= 0 && objetos[j] instanceof Pelota && objetoAux instanceof Pelota ? ((Pelota) objetos[j]).calculaVolumen() > ((Pelota) objetoAux).calculaVolumen() : (objetos[j] instanceof PoligonoPlano && objetoAux instanceof PoligonoPlano) && ((PoligonoPlano) objetos[j]).calcularArea() > ((PoligonoPlano) objetoAux).calcularArea(); j--) {
                    objetos[j + 1] = objetos[j];
                    objetos[j] = objetoAux;
                }
            }
        } else
            System.out.println("Este robot no tiene ningun objeto");
    }

    private int devolverPosicionObjeto(Objeto objeto) {

        for (int i = 0; i < objetos.length; i++)
            if (objeto.equals(objetos[i]))
                return i;

        return -1;
    }

    @Override
    public void mostrarRobot() {
        System.out.println("ROBOT COGEDOR\n");
        super.mostrarRobot();
        System.out.println("\nBRAZO ALCANZA: " + brazoAlcanza);
        System.out.println("OBJETOS COGIDOS: " + numeroObjetos);
    }

    @Override
    public void movimientoDiagonal(int numeroPasos, String movimiento, int frontX, int frontY, int frontNegX, int frontNegY) {

    }


    public void mostrarObjetosCogidos() {

        if (numeroObjetos > 0) {
            for (int i = 0; i < numeroObjetos; i++) {
                System.out.println("OBJETO ---------------- " + i);
                System.out.println(objetos[i].toString());
            }
        } else
            System.out.println("Este robot no tiene ningun objeto");
    }
}
