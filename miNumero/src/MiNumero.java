/*
        Realiza una clase MiNumero que permita, mediante los métodos correspondientes, devolver el
        doble, el triple y el cuadruple del número que tiene la clase como atributo. Usa un constructor con
        un parámetro tipo entero.
 */
public class MiNumero {
    //Atributos
    int numero;

    //Constructor
    // Vacio (Por defecto)
    public MiNumero()
    {
        numero = 0;
    }

    // Con parametros (Sobrecargado)
    public MiNumero(int numero)
    {
        this.numero = numero;
    }

    // Copia
    public MiNumero(MiNumero miNumero)
    {
        this.numero = miNumero.numero;
    }

    //Metodos consultores (getters)
    public int getNumero() {
        return numero;
    }

    //Metodos modificadores
    public void setNumero(int numero) {
        this.numero = numero;
    }

    //Metodos añadidos
    public int devolverDoble()
    {
        return this.numero * 2;
    }

    public int devolverTriple()
    {
        return this.numero * 3;
    }

    public int devolverCuadruple()
    {
        return this.numero * 4;
    }

    public int devolverNumeroMultiplicado(int multiplicador)
    {
        return this.numero * multiplicador;
    }
}




